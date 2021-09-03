module Pages.Study exposing (Model, Msg(..), page)

import Effect exposing (Effect)
import Gen.Params.Study exposing (Params)
import Api.Card exposing (CardEnvelope, FlashCard(..), Grade(..), CardId, StudySessionSummary)
import Api.User exposing (User)
import Api.Data exposing (..)
import Api.Data as Data
import Page
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Bridge exposing (ToBackend(..))
import Lamdera
import Request
import Shared
import List exposing (..)
import View exposing (View)
import Page
import Bridge exposing (sendToBackend)
import Dict
import Api.Card exposing (PlainTextCard)
-- import Gen.Model exposing (Model(..))


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared _ =
    Page.protected.advanced
        (\user ->
            { init = init shared
            , update = update
            , subscriptions = subscriptions
            , view = view user
            }
        )

-- INIT


type alias Model =
    {
        cardDataFetch : Data (List CardEnvelope)
        -- TODO: Prompt state needs to be a variant type once other flashcard variants are implemented!
        --       I'm not sure where that should live, so punting on that decision atm.
        , promptStatus : PromptStatus
        , gradeSubmit : Data (CardId)
        , sessionSummary : Data (StudySessionSummary)
    }


type Msg
    = FetchCards User
    | GotUserCards (Data (List CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade CardId Grade
    | GotGradedResponse (Data CardId)
    | GotStudySessionSummary (Data StudySessionSummary)


init : Shared.Model -> ( Model, Effect Msg )
init shared =
    let
        -- if a user is present, we fetch their study session summary immediately
        shouldFetchSummary = case shared.user of
            Just _ ->
                Loading

            Nothing ->
                NotAsked

        model_ = {
                cardDataFetch = NotAsked
                , sessionSummary = shouldFetchSummary
                , promptStatus = Idle
                , gradeSubmit = NotAsked
            }
        
        effect_ = case model_.sessionSummary of
            Loading ->
                Effect.fromCmd <| fetchUsersStudySessionSumary shared
            _ ->
                Effect.none
    in
    (model_, effect_)


fetchUsersStudyCards : Shared.Model -> Model -> Cmd Msg
fetchUsersStudyCards shared _ =
    case shared.user of
        Just user ->
            sendToBackend <| FetchUsersStudyCards_Study user
        Nothing ->
            Cmd.none


fetchUsersStudySessionSumary : Shared.Model -> Cmd Msg
fetchUsersStudySessionSumary shared =
    case shared.user of
        Just user ->
            sendToBackend <| FetchUsersStudySummary_Study user
        Nothing ->
            Cmd.none


-- UPDATE




update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        FetchCards user ->
            ( model, Effect.none )
        
        GotUserCards cards ->
            ({model | cardDataFetch = cards, promptStatus = QuestionPrompted}, Effect.none)
        
        UserClickedReveal ->
            ({model | promptStatus = AnswerRevealed}, Effect.none)
        
        UserSelfGrade cardId grade ->
            -- TODO: It feels a bit weird to be passing this to the backend, but otherwise I'm not sure how
            --       To have a polymorphic grading model without this.. need to think on it.
            (
                {model | gradeSubmit = Loading}
                , Effect.fromCmd <| (UserSubmitGrade_Study cardId grade |> Lamdera.sendToBackend)
            )
        
        GotGradedResponse cardId ->
        -- We've received a graded response from the backend:
        --    1) update gradeSubmit status
        --    2) pop the graded card off our card list
        --    3) reset prompt status, which will prompt for the next card
            let
                maybeCardId = Data.toMaybe cardId
                maybeCards = Data.toMaybe model.cardDataFetch
                updatedCards = case maybeCards of
                    Just cards ->
                        let
                            isCard : Maybe CardId -> CardEnvelope-> Bool
                            isCard  id env  =
                                case id of
                                    Just v ->
                                        env.id /= v
                                    Nothing ->
                                        False -- TODO: barf??
                            -- This feels a bit odd, but rather than fetch all cards from the backend again, we can
                            -- sneakily reset the state here to the
                            newCards = List.filter (isCard maybeCardId) cards
                        in
                        Success newCards
                    Nothing ->
                    -- This shouldn't happen. it would mean we've received a graded card response while our current
                    -- user has no cards. Let's reset state /shrug
                        NotAsked
            in
            
            ({model 
            | gradeSubmit = cardId
            , cardDataFetch = updatedCards
            , promptStatus = Idle
            }, Effect.none)
        
        GotStudySessionSummary summary ->
            ({model 
            | sessionSummary = summary
            }, Effect.none)
            

-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : User -> Model -> View Msg
view _ model =
    { title = "Title string for cards"
    , body = [layout [] <| viewElements model]
    }


viewElements : Model -> Element Msg
viewElements model =
    Element.column [centerX] [
        viewStudySessionSummary model.sessionSummary
        , viewPrompt model
        , viewGradeSumbissionPanel model
    ]


viewGradeSumbissionPanel : Model -> Element Msg
viewGradeSumbissionPanel model =
    let
        elements = case model.gradeSubmit of
            NotAsked ->
                Element.none

            Loading ->
                Element.text "Awaiting grade from server.."

            Failure errs ->
                    Element.column [] <| List.map (\e -> Element.text e) errs

            Success cardId ->
                Element.text <| "card " ++ String.fromInt cardId ++ " was successfully graded"
    in
    elements
    


viewPlainTextFlashcardPrompt : PlainTextCard -> CardId -> PromptStatus -> Element Msg
viewPlainTextFlashcardPrompt card cId ps =
    let
        elements = case ps of
            Idle ->
                Element.none
            QuestionPrompted ->
                 Element.column [
                    Border.width 2
                    , Border.color colors.darkCharcoal
                    , padding 10
                    , spacing 20
                ] [
                    Element.text card.question
                    , Element.row [spacing 10] [
                        Input.button
                            [ Background.color colors.darkCharcoal
                            , Font.color colors.lightBlue
                            , Border.color colors.lightGrey
                            , paddingXY 32 16
                            , Border.rounded 3
                            , Element.width fill
                            ]
                            {
                                onPress = Just UserClickedReveal
                                , label = Element.text "Reveal"
                            }
                    ]
                ]
            AnswerRevealed ->
                Element.column [
                    Border.width 2
                    , Border.color colors.darkCharcoal
                    , padding 10
                    , spacing 20
                ] [
                    Element.text card.question
                    , Element.text card.answer
                    , Element.row [spacing 10] [
                        Input.button
                            [ Background.color colors.darkCharcoal
                            , Font.color colors.lightBlue
                            , Border.color colors.lightGrey
                            , paddingXY 32 16
                            , Border.rounded 3
                            , Element.width fill
                            ]
                            {
                                onPress = Just <| UserSelfGrade cId Incorrect
                                , label = Element.text "X"
                            }
                        , Input.button
                            [ Background.color colors.darkCharcoal
                            , Font.color colors.lightBlue
                            , Border.color colors.lightGrey
                            , paddingXY 32 16
                            , Border.rounded 3
                            , Element.width fill
                            ]
                            {
                                onPress = Just <| UserSelfGrade cId Correct 
                                , label = Element.text "✔"
                            }
                    ]
                ]
    in
    elements

viewStudySessionSummary : Data StudySessionSummary -> Element Msg
viewStudySessionSummary summary =
    let
        elements = case summary of
            NotAsked ->
                Element.text "not asked"
            Loading ->
                Element.text "loading"
            Success s ->
                Element.column [] [
                    Element.text <| "Summary:"
                    , Element.text <| "\tcards to study today: " ++ String.fromInt s.cardsToStudy
                    , Element.text <| "\tyour total card count: " ++ String.fromInt s.usersTotalCardCount
                ]
            Failure errs ->
                Element.column [] <| List.map (\e -> Element.text e) errs
    in
    elements
    

viewPrompt : Model -> Element Msg
viewPrompt model =
    let
        elements = case model.cardDataFetch of
            NotAsked ->
                Element.text "Not asked."
            Loading ->
                Element.text "Loading.."
            Failure errs ->
                Element.column [] <| List.map (\e -> Element.text e) errs
            Success cards ->
                let
                    card = List.head cards
                    els = case card of
                        Just env ->
                            case env.card of
                                FlashCardPlainText plainTextCard ->
                                    viewPlainTextFlashcardPrompt plainTextCard env.id model.promptStatus
                        Nothing ->
                            Element.text "You have studied all your cards!"
                in
                
                Element.column [] [
                    els
                ]      
    in
    Element.column [padding 10, spacing 10 ] [elements]


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed

colors =
    { blue = rgb255 0x72 0x9F 0xCF
    , darkCharcoal = rgb255 0x2E 0x34 0x36
    , lightBlue = rgb255 0xC5 0xE8 0xF7
    , lightGrey = rgb255 0xE0 0xE0 0xE0
    , white = rgb255 0xFF 0xFF 0xFF
    }
