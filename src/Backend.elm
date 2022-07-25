module Backend exposing (..)

import Api.Card exposing (CardEnvelope, CardId, FlashCard, PromptFrequency(..), processGrade)
import Api.Data exposing (Data(..))
import Api.Profile exposing (Profile)
import Api.User exposing (Email, User, UserFull, UserId)
import Bridge exposing (ToBackend(..))
import Debug
import Dict
import Dict.Extra as Dict
import Duration exposing (Duration)
import Gen.Msg
import Lamdera exposing (..)
import List.Extra as List
import Pages.Cards
import Pages.Catalog
import Pages.Home_
import Pages.Login
import Pages.Profile.Username_
import Pages.Register
import Pages.Settings
import Pages.Study
import Task exposing (Task)
import Time
import Time.Extra as Time
import Types exposing (BackendModel, BackendMsg(..), FrontendMsg(..), ToFrontend(..))
import Utils.Task as Utils


type alias Model =
    BackendModel


ticMs =
    1000


app : { init : ( Model, Cmd BackendMsg ), update : BackendMsg -> Model -> ( Model, Cmd BackendMsg ), updateFromFrontend : SessionId -> ClientId -> ToBackend -> Model -> ( Model, Cmd BackendMsg ), subscriptions : Model -> Sub BackendMsg }
app =
    Lamdera.backend
        { init = init
        , update = update
        , updateFromFrontend = updateFromFrontend
        , subscriptions = subscriptions
        }


subscriptions : Model -> Sub BackendMsg
subscriptions model =
    Sub.batch
        [ onConnect CheckSession
        , Time.every ticMs Tick
        ]


init : ( Model, Cmd BackendMsg )
init =
    ( { sessions = Dict.empty
      , users = Dict.empty
      , cards = Dict.empty
      , now = Time.millisToPosix 0 -- Setting this to 0 here is a bit of a hack, but the server's init basically never runs after launch, so this'll do
      , nextCardId = 1000 -- setting to a high number incase I've deleted some. A one-time evergreen related thing
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
            ( { model | now = time }, Cmd.none )

        IncrementCardId ->
            ( { model | nextCardId = model.nextCardId + 1 }, Cmd.none )

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
                cardId =
                    model.nextCardId

                envelope =
                    { id = cardId
                    , card = flashCard
                    , userId = userId
                    , createdAt = model.now
                    , lastModifiedOn = model.now
                    , nextPromptSchedFor = model.now
                    , frequency = Immediately
                    }

                cards_ =
                    Dict.insert cardId envelope model.cards
            in
            ( { model | cards = cards_ }
            , Cmd.batch
                [ Utils.send IncrementCardId
                , send_ (PageMsg (Gen.Msg.Cards (Pages.Cards.GotCard <| Success cardId)))
                ]
            )

        FetchUsersStudyCards_Study user ->
            -- Fetches cards for the case of starting a study session. criteria:
            --      * cards belong to the user
            --      * card's next prompt schedule is in the past
            let
                userCards =
                    Dict.filter
                        (\_ cardEnv ->
                            (cardEnv.userId == user.id)
                                && (Time.posixToMillis cardEnv.nextPromptSchedFor <= Time.posixToMillis model.now)
                        )
                        model.cards

                asList =
                    Dict.values userCards
            in
            ( model, send_ (PageMsg (Gen.Msg.Study (Pages.Study.GotUserCards <| Success asList))) )

        FetchUsersCatalog_Catalog user ->
            -- Fetches all cards belonging to a user, note this doesn't take time into account!
            let
                userCards =
                    Dict.filter
                        (\_ cardEnv ->
                            cardEnv.userId == user.id
                        )
                        model.cards

                asList =
                    Dict.values userCards
            in
            ( model, send_ (PageMsg (Gen.Msg.Catalog (Pages.Catalog.GotUserCatalog <| Success asList))) )

        DeleteCard_Catalog cardId userId ->
            let
                targetCard : Maybe CardEnvelope
                targetCard =
                    Dict.get cardId model.cards

                newCards : Dict.Dict CardId CardEnvelope
                newCards =
                    case targetCard of
                        Nothing ->
                            -- if cardId isn't found, don't delete
                            model.cards

                        Just cardEnv ->
                            if cardEnv.userId == userId then
                                -- TODO: user feedback on this.. though it's an edge case so not sure I care..
                                -- if cardId isn't owned by our user, don't delete
                                Dict.remove cardId model.cards

                            else
                                model.cards
            in
            ( { model | cards = newCards }, send_ (PageMsg (Gen.Msg.Catalog (Pages.Catalog.GotDeleteCardResponse cardId))) )

        UserSubmitGrade_Study cardId grade_ ->
            -- We've received a msg to apply this grade to the specified cardId
            let
                card =
                    Dict.get cardId model.cards
            in
            case card of
                Nothing ->
                    -- TODO: Error handling here
                    ( model, Cmd.none )

                Just card_ ->
                    let
                        c =
                            processGrade model.now card_ grade_

                        cards =
                            Dict.insert c.id c model.cards
                    in
                    ( { model | cards = cards }, send_ (PageMsg (Gen.Msg.Study (Pages.Study.GotGradedResponse <| Success c.id))) )

        FetchUsersStudySummary_Study user ->
            let
                totalUserCards =
                    Dict.filter (\_ cardEnv -> cardEnv.userId == user.id) model.cards |> Dict.size

                cardsToStudyNow =
                    Dict.filter (\_ cardEnv -> cardEnv.userId == user.id && isCardScheduled model.now cardEnv) model.cards |> Dict.size

                studySessionSummary =
                    { usersTotalCardCount = totalUserCards
                    , cardsToStudy = cardsToStudyNow
                    }
            in
            ( model
            , send_ (PageMsg (Gen.Msg.Study (Pages.Study.GotStudySessionSummary <| Success studySessionSummary)))
            )


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



-- utiliity funcs


isCardScheduled : Time.Posix -> CardEnvelope -> Bool
isCardScheduled now cardEnv =
    Time.posixToMillis now >= Time.posixToMillis cardEnv.nextPromptSchedFor
