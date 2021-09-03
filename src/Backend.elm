module Backend exposing (..)

import Api.Data exposing (Data(..))
import Api.Profile exposing (Profile)
import Api.User exposing (Email, UserFull, UserId)
import Bridge exposing (..)
import Dict
import Dict.Extra as Dict
import Duration exposing (Duration)
import Gen.Msg
import Lamdera exposing (..)
import List.Extra as List
import Pages.Home_
import Pages.Login
import Pages.Cards
import Pages.Study
import Pages.Profile.Username_
import Pages.Register
import Pages.Settings
import Task exposing (Task)
import Time
import Time.Extra as Time
import Types exposing (BackendModel, BackendMsg(..), FrontendMsg(..), ToFrontend(..))
import Api.Card exposing (CardId, FlashCard, CardEnvelope, PromptFrequency(..), grade)
import Api.Card exposing (FlashCard)
import Api.Card exposing (CardEnvelope)


type alias Model =
    BackendModel


app : { init : (Model, Cmd BackendMsg), update : BackendMsg -> Model -> (Model, Cmd BackendMsg), updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> (Model, Cmd BackendMsg), subscriptions : Model -> Sub BackendMsg }
app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub BackendMsg
subscriptions model =
    Sub.batch [
        onConnect CheckSession
        , Time.every 10000 Tick
    ]

init : ( Model, Cmd BackendMsg )
init =
    ( { sessions = Dict.empty
      , users = Dict.empty
      , cards = Dict.empty
      , now = Time.millisToPosix 0 -- Setting this to 0 here is a bit of a hack, but the server's init basically never runs after launch, so this'll do
      }
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        CheckSession sid cid ->
            model
                |> getSessionUser sid
                |> Maybe.map (\user -> ( model, sendToFrontend cid (ActiveSession (Api.User.toUser user)) ))
                |> Maybe.withDefault ( model, Cmd.none )

        RenewSession uid sid cid now ->
            ( { model | sessions = model.sessions |> Dict.update sid (always (Just { userId = uid, expires = now |> Time.add Time.Day 30 Time.utc })) }
            , Time.now |> Task.perform (always (CheckSession sid cid))
            )
        
       
        Tick time ->
            ({model | now = time}, Cmd.none)

        NoOpBackendMsg ->
            ( model, Cmd.none )


updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg )
updateFromFrontend sessionId clientId msg model =
    let
        send v =
            ( model, send_ v )

        send_ v =
            sendToFrontend clientId v
    in
    case msg of
        SignedOut user ->
            ( { model | sessions = model.sessions |> Dict.remove sessionId }, Cmd.none )
       
        ProfileGet_Profile__Username_ { username } ->
            let
                res =
                    profileByUsername username model
                        |> Maybe.map Success
                        |> Maybe.withDefault (Failure [ "user not found" ])
            in
            send <| PageMsg (Gen.Msg.Profile__Username_ (Pages.Profile.Username_.GotProfile res))


        UserAuthentication_Login { params } ->
            let
                ( response, cmd ) =
                    model.users
                        |> Dict.find (\k u -> u.email == params.email)
                        |> Maybe.map
                            (\( k, u ) ->
                                if u.password == params.password then
                                    ( Success (Api.User.toUser u), renewSession u.id sessionId clientId )

                                else
                                    ( Failure [ "email or password is invalid" ], Cmd.none )
                            )
                        |> Maybe.withDefault ( Failure [ "email or password is invalid" ], Cmd.none )
            in
            ( model, Cmd.batch [ send_ (PageMsg (Gen.Msg.Login (Pages.Login.GotUser response))), cmd ] )

        UserRegistration_Register { params } ->
            let
                ( model_, cmd, res ) =
                    if model.users |> Dict.any (\k u -> u.email == params.email) then
                        ( model, Cmd.none, Failure [ "email address already taken" ] )

                    else
                        let
                            user_ =
                                { id = Dict.size model.users
                                , email = params.email
                                , username = params.username
                                , bio = Nothing
                                , image = "https://static.productionready.io/images/smiley-cyrus.jpg"
                                , password = params.password
                                }
                        in
                        ( { model | users = model.users |> Dict.insert user_.id user_ }
                        , renewSession user_.id sessionId clientId
                        , Success (Api.User.toUser user_)
                        )
            in
            ( model_, Cmd.batch [ cmd, send_ (PageMsg (Gen.Msg.Register (Pages.Register.GotUser res))) ] )

        UserUpdate_Settings { params } ->
            let
                ( model_, res ) =
                    case model |> getSessionUser sessionId of
                        Just user ->
                            let
                                user_ =
                                    { user
                                        | username = params.username

                                        -- , email = params.email
                                        , password = params.password |> Maybe.withDefault user.password
                                        , image = params.image
                                        , bio = Just params.bio
                                    }
                            in
                            ( model |> updateUser user_, Success (Api.User.toUser user_) )

                        Nothing ->
                            ( model, Failure [ "you do not have permission for this user" ] )
            in
            ( model_, send_ (PageMsg (Gen.Msg.Settings (Pages.Settings.GotUser res))) )

        CreateCard_Cards flashCard userId ->
            let
                cardId = (Dict.size model.cards) + 1
                envelope =
                    {
                        id =cardId
                        , card=flashCard
                        , userId=userId
                        , createdAt=model.now
                        , lastModifiedOn=model.now
                        , nextPromptSchedFor=model.now
                        , frequency=Immediately
                    } 
                cards_ = Dict.insert cardId envelope model.cards
            in

            ({model | cards = cards_}, send_ (PageMsg (Gen.Msg.Cards (Pages.Cards.GotCard <| Success cardId))))

        FetchUsersStudyCards_Study user ->
            let
                userCards = Dict.filter (\_ env -> env.userId == user.id) model.cards
                asList = Dict.values userCards
            in
            (model, send_ (PageMsg (Gen.Msg.Study (Pages.Study.GotUserCards <| Success asList))))
        
        UserSubmitGrade_Study cardId grade_ ->
            -- We've received a msg to apply this grade to the specified cardId
            let 
                card = Dict.get cardId model.cards
            in
            case card of
                Nothing ->
                    -- TODO: Error handling here
                    (model, Cmd.none)
                Just card_ ->
                    let
                        c = grade model.now card_ grade_
                        cards = Dict.insert c.id c model.cards
                    in
                    ({model | cards = cards}, send_ (PageMsg (Gen.Msg.Study (Pages.Study.GotGradedResponse <| Success c.id))))


getSessionUser : SessionId -> Model -> Maybe UserFull
getSessionUser sid model =
    model.sessions
        |> Dict.get sid
        |> Maybe.andThen (\session -> model.users |> Dict.get session.userId)


renewSession email sid cid =
    Time.now |> Task.perform (RenewSession email sid cid)


updateUser : UserFull -> Model -> Model
updateUser user model =
    { model | users = model.users |> Dict.update user.id (Maybe.map (always user)) }


profileByUsername username model =
    model.users |> Dict.find (\k u -> u.username == username) |> Maybe.map (Tuple.second >> Api.User.toProfile)


profileByEmail email model =
    model.users |> Dict.find (\k u -> u.email == email) |> Maybe.map (Tuple.second >> Api.User.toProfile)
