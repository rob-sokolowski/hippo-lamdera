module Backend exposing (..)

import Api.Admin exposing (AdminSummary)
import Api.Card exposing (CardEnvelope, CardId, FlashCard(..), PromptFrequency(..), processGrade)
import Api.Data exposing (Data(..))
import Api.Profile exposing (Profile)
import Api.User exposing (Email, User, UserFull, UserId)
import Auth.Flow
import AuthImplementation
import Bridge exposing (ToBackend(..))
import Dict
import Dict.Extra as Dict
import Duration exposing (Duration)
import Gen.Msg
import Lamdera exposing (..)
import Pages.Admin
import Pages.Cards
import Pages.Catalog
import Pages.Study
import Task exposing (Task)
import Time
import Time.Extra as Time
import Types exposing (BackendModel, BackendMsg(..), FrontendMsg(..), ToFrontend(..))
import Utils.Task as Utils


type alias Model =
    BackendModel


ticMs =
    10000000


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
      , pendingAuths = Dict.empty
      }
    , Cmd.none
    )


update : BackendMsg -> Model -> ( Model, Cmd BackendMsg )
update msg model =
    case msg of
        AuthBackendMsg authMsg ->
            Auth.Flow.backendUpdate (AuthImplementation.backendConfig model) authMsg

        CheckSession sid cid ->
            model
                |> AuthImplementation.getSessionUser sid
                |> Maybe.map (\user -> ( model, sendToFrontend cid (ActiveSession (Api.User.toUser user)) ))
                |> Maybe.withDefault ( model, Cmd.none )

        RenewSession uid sid cid now ->
            ( { model | sessions = model.sessions |> Dict.update sid (always (Just { userId = uid, expires = now |> Time.add Time.Day 30 Time.utc })) }
            , Time.now |> Task.perform (always (CheckSession sid cid))
            )

        Tick time ->
            ( { model | now = time }, Cmd.none )

        NoOpBackendMsg ->
            ( model, Cmd.none )

        EVERGREEN_NOOP ->
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
        AuthToBackend authToBackend ->
            Auth.Flow.updateFromFrontend (AuthImplementation.backendConfig model) clientId sessionId authToBackend model

        SignedOut user ->
            ( { model | sessions = model.sessions |> Dict.remove sessionId }, Cmd.none )

        FetchAdminSummary user ->
            case user.email of
                "rpsoko@gmail.com" ->
                    let
                        adminSummaries : List AdminSummary
                        adminSummaries =
                            Dict.values <|
                                Dict.map
                                    (\_ cardEnv ->
                                        { cardId = cardEnv.id
                                        , userId = cardEnv.userId
                                        , question =
                                            case cardEnv.card of
                                                PlainText card_ ->
                                                    card_.question

                                                Markdown card_ ->
                                                    card_.question
                                        , answer =
                                            case cardEnv.card of
                                                PlainText card_ ->
                                                    card_.answer

                                                Markdown card_ ->
                                                    card_.answer
                                        }
                                    )
                                    model.cards
                    in
                    ( model, send_ (PageMsg (Gen.Msg.Admin (Pages.Admin.GotAdminSummary adminSummaries))) )

                _ ->
                    ( model, Cmd.none )

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
            ( { model | cards = cards_, nextCardId = model.nextCardId + 1 }
            , Cmd.batch
                [ send_ (PageMsg (Gen.Msg.Cards (Pages.Cards.GotCard <| Success cardId)))
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
