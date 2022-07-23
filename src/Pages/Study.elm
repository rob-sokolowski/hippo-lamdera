module Pages.Study exposing (Model, Msg(..), page)

import Api.Card exposing (CardEnvelope, CardId, FlashCard(..), Grade(..), MarkdownCard, PlainTextCard, StudySessionSummary)
import Api.Data as Data exposing (..)
import Api.User exposing (User)
import Bridge exposing (ToBackend(..), sendToBackend)
import Components.Styling as Styling
import Dict
import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Gen.Params.Study exposing (Params)
import Html exposing (Html)
import Lamdera
import List exposing (..)
import Markdown.Option exposing (..)
import Markdown.Render
import Page
import Request
import Shared
import View exposing (View)


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
    { cardDataFetch : Data (List CardEnvelope)

    -- TODO: Prompt state needs to be a variant type once other flashcard variants are implemented!
    --       I'm not sure where that should live, so punting on that decision atm.
    , promptStatus : PromptStatus
    , gradeSubmit : Data CardId
    , sessionSummary : Data StudySessionSummary
    , user : Maybe User
    }


type Msg
    = FetchCards User
    | GotUserCards (Data (List CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade CardId Grade
    | GotGradedResponse (Data CardId)
    | GotStudySessionSummary (Data StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg


init : Shared.Model -> ( Model, Effect Msg )
init shared =
    let
        -- if a user is present, we fetch their study session summary immediately
        shouldFetchSummary =
            case shared.user of
                Just _ ->
                    Loading

                Nothing ->
                    NotAsked

        model_ =
            { cardDataFetch = NotAsked
            , sessionSummary = shouldFetchSummary
            , promptStatus = Idle
            , gradeSubmit = NotAsked
            , user = shared.user
            }

        effect_ =
            case model_.sessionSummary of
                Loading ->
                    Effect.fromCmd <| fetchUsersStudySessionSumary shared

                _ ->
                    Effect.none
    in
    ( model_, effect_ )


fetchUsersStudyCards : Maybe User -> Cmd Msg
fetchUsersStudyCards user =
    case user of
        Just u ->
            sendToBackend <| FetchUsersStudyCards_Study u

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
            ( { model | cardDataFetch = cards, promptStatus = QuestionPrompted }, Effect.none )

        UserClickedReveal ->
            ( { model | promptStatus = AnswerRevealed }, Effect.none )

        UserSelfGrade cardId grade ->
            -- TODO: It feels a bit weird to be passing this to the backend, but otherwise I'm not sure how
            --       To have a polymorphic grading model without this.. need to think on it.
            ( { model | gradeSubmit = Loading }
            , Effect.fromCmd <| (UserSubmitGrade_Study cardId grade |> Lamdera.sendToBackend)
            )

        GotGradedResponse cardId ->
            -- We've received a graded response from the backend:
            --    1) update gradeSubmit status
            --    2) pop the graded card off our card list
            --    3) reset prompt status, which will prompt for the next card
            let
                maybeCardId =
                    Data.toMaybe cardId

                maybeCards =
                    Data.toMaybe model.cardDataFetch

                ( updatedCards, effect ) =
                    case maybeCards of
                        Just cards ->
                            let
                                isCard : Maybe CardId -> CardEnvelope -> Bool
                                isCard id env =
                                    case id of
                                        Just v ->
                                            env.id /= v

                                        Nothing ->
                                            False

                                -- TODO: barf??
                                -- This feels a bit odd, but rather than fetch all cards from the backend again, we can
                                -- sneakily reset the state here to the
                                newCards =
                                    List.filter (isCard maybeCardId) cards

                                -- if we've reached the end of our study session
                                eff =
                                    if List.length newCards > 0 then
                                        Effect.none

                                    else
                                        Effect.fromCmd <| fetchUsersStudyCards model.user
                            in
                            ( Success newCards, eff )

                        Nothing ->
                            -- This shouldn't happen. it would mean we've received a graded card response while our current
                            -- user has no cards. Let's reset state /shrug
                            ( NotAsked, Effect.none )
            in
            ( { model
                | gradeSubmit = cardId
                , cardDataFetch = updatedCards
                , promptStatus = QuestionPrompted
              }
            , effect
            )

        GotStudySessionSummary summary ->
            ( { model
                | sessionSummary = summary
              }
            , Effect.none
            )

        UserStartStudySession ->
            ( model
            , Effect.fromCmd <| fetchUsersStudyCards model.user
            )

        MarkdownMsg _ ->
            ( model, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : User -> Model -> View Msg
view _ model =
    { title = "Study Your Cards"
    , body =
        [ viewElements model
        ]
    }


viewElements : Model -> Element Msg
viewElements model =
    let
        viewGradeSubmissionPanel : Element Msg
        viewGradeSubmissionPanel =
            case model.gradeSubmit of
                NotAsked ->
                    E.none

                Loading ->
                    E.text "Awaiting grade from server.."

                Failure errs ->
                    E.column [] <| List.map (\e -> E.text e) errs

                Success cardId ->
                    el [ Font.size 14, paddingEach { top = 10, right = 0, left = 0, bottom = 10 } ] <| E.text <| "card " ++ String.fromInt cardId ++ " was successfully graded"

        viewPrompt : Element Msg
        viewPrompt =
            case model.cardDataFetch of
                NotAsked ->
                    E.column
                        [ centerX
                        , height fill
                        ]
                        [ el [ centerY ] <| text "Click to start today's session"
                        , Input.button
                            [ Background.color colors.darkCharcoal
                            , Font.color colors.lightBlue
                            , Border.color colors.lightGrey
                            , paddingXY 32 16
                            , centerY
                            , Border.rounded 3
                            , E.width fill
                            ]
                            { onPress = Just UserStartStudySession
                            , label = E.text "Start session."
                            }
                        ]

                Loading ->
                    E.text "Loading.."

                Failure errs ->
                    E.column [] <| List.map (\e -> E.text e) errs

                Success cards ->
                    let
                        card =
                            List.head cards
                    in
                    case card of
                        Just env ->
                            case env.card of
                                PlainText card_ ->
                                    viewPlainTextFlashcardPrompt card_ env.id model.promptStatus

                                Markdown card_ ->
                                    viewMarkdownFlashcardPrompt card_ env.id model.promptStatus

                        Nothing ->
                            E.text "You have studied all your cards!"
    in
    E.row
        [ padding 0
        , spacing 10
        , width fill
        , height fill
        , Border.width 1
        , Border.color Styling.red
        ]
        [ E.column
            [ width <| fillPortion 2
            , height fill
            , alignTop
            , alignRight
            ]
            [ viewStudySessionSummary model.sessionSummary
            , viewGradeSubmissionPanel
            ]
        , E.column
            [ width <| fillPortion 8
            , height fill
            , alignTop
            ]
            [ viewPrompt
            ]
        ]


viewMarkdownFlashcardPrompt : MarkdownCard -> CardId -> PromptStatus -> Element Msg
viewMarkdownFlashcardPrompt card cid ps =
    let
        elements =
            case ps of
                Idle ->
                    E.none

                QuestionPrompted ->
                    E.column
                        [ Border.width 1
                        , Border.color Styling.black
                        , Background.color Styling.softGrey
                        , padding 10
                        , spacing 10
                        , centerX
                        ]
                        [ el
                            [ Background.color Styling.white
                            , Border.rounded 10
                            , padding 10
                            , E.width <| E.minimum 800 fill
                            , E.height <| E.minimum 400 fill
                            ]
                          <|
                            viewRenderedQuestion card
                        , el
                            [ E.width <| px 800
                            , E.height <| E.minimum 400 fill
                            ]
                          <|
                            Input.button
                                [ Background.color Styling.medGrey
                                , Font.color Styling.black
                                , Font.bold
                                , Border.color Styling.dimGrey
                                , Border.width 5
                                , paddingXY 32 16
                                , Border.rounded 10
                                , E.width fill
                                , E.height fill
                                , centerX
                                ]
                                { onPress = Just UserClickedReveal
                                , label = el [ centerX ] <| E.text "Reveal"
                                }
                        ]

                AnswerRevealed ->
                    E.column
                        [ Border.width 5
                        , Border.color colors.darkCharcoal
                        , Background.color Styling.softGrey
                        , spacing 5
                        , height fill
                        , centerX
                        ]
                        [ el
                            [ Background.color Styling.white
                            , Border.rounded 10
                            , padding 10
                            , E.width <| E.minimum 600 fill
                            , E.height <| E.minimum 250 fill
                            ]
                          <|
                            viewRenderedQuestion card
                        , E.column [ spacing 5 ]
                            [ el
                                [ Background.color Styling.white
                                , Border.rounded 10
                                , padding 10
                                , E.width <| E.minimum 600 fill
                                , E.height <| E.minimum 300 fill
                                ]
                              <|
                                viewRenderedAnswer card
                            , E.row
                                [ spacing 10
                                , E.width fill
                                , E.height <| E.minimum 60 <| E.maximum 100 fill
                                , Font.size 36
                                ]
                                [ Input.button
                                    [ Background.color Styling.medGrey
                                    , Font.color Styling.black
                                    , Font.bold
                                    , Border.color Styling.black
                                    , Border.rounded 5
                                    , E.width fill
                                    , E.height fill
                                    ]
                                    { onPress = Just <| UserSelfGrade cid Incorrect
                                    , label = el [ centerX ] <| E.text "X"
                                    }
                                , Input.button
                                    [ Background.color Styling.medGrey
                                    , Font.color Styling.black
                                    , Border.color colors.lightGrey
                                    , Border.rounded 10
                                    , Border.rounded 5
                                    , E.width fill
                                    , E.height fill
                                    ]
                                    { onPress = Just <| UserSelfGrade cid Correct
                                    , label = el [ centerX ] <| E.text "✔"
                                    }
                                ]
                            ]
                        ]
    in
    elements


viewRenderedQuestion : MarkdownCard -> Element Msg
viewRenderedQuestion card =
    E.html
        (Markdown.Render.toHtml ExtendedMath card.question |> Html.map MarkdownMsg)


viewRenderedAnswer : MarkdownCard -> Element Msg
viewRenderedAnswer card =
    E.html
        (Markdown.Render.toHtml ExtendedMath card.answer |> Html.map MarkdownMsg)


viewPlainTextFlashcardPrompt : PlainTextCard -> CardId -> PromptStatus -> Element Msg
viewPlainTextFlashcardPrompt card cid ps =
    let
        elements =
            case ps of
                Idle ->
                    E.none

                QuestionPrompted ->
                    E.column
                        [ Border.width 2
                        , Border.color colors.darkCharcoal
                        , padding 10
                        , spacing 20
                        , centerX
                        ]
                        [ E.text card.question
                        , E.row [ spacing 10 ]
                            [ Input.button
                                [ Background.color colors.darkCharcoal
                                , Font.color colors.lightBlue
                                , Border.color colors.lightGrey
                                , paddingXY 32 16
                                , Border.rounded 3
                                , E.width fill
                                ]
                                { onPress = Just UserClickedReveal
                                , label = E.text "Reveal"
                                }
                            ]
                        ]

                AnswerRevealed ->
                    E.column
                        [ padding 10
                        ]
                        [ E.text card.question
                        , E.text card.answer
                        , E.row [ spacing 10 ]
                            [ Input.button
                                [ Background.color colors.darkCharcoal
                                , Font.color colors.lightBlue
                                , Border.color colors.lightGrey
                                , paddingXY 32 16
                                , Border.rounded 3
                                , E.width fill
                                ]
                                { onPress = Just <| UserSelfGrade cid Incorrect
                                , label = E.text "X"
                                }
                            , Input.button
                                [ Background.color colors.darkCharcoal
                                , Font.color colors.lightBlue
                                , Border.color colors.lightGrey
                                , paddingXY 32 16
                                , Border.rounded 3
                                , E.width fill
                                ]
                                { onPress = Just <| UserSelfGrade cid Correct
                                , label = E.text "✔"
                                }
                            ]
                        ]
    in
    elements


viewStudySessionSummary : Data StudySessionSummary -> Element Msg
viewStudySessionSummary summary =
    let
        elements =
            case summary of
                NotAsked ->
                    E.text "not asked"

                Loading ->
                    E.text "loading"

                Success s ->
                    E.column [ Font.size 14 ]
                        [ E.text <| "Summary:"
                        , E.text <| "\tcards to study today: " ++ String.fromInt s.cardsToStudy
                        , E.text <| "\tyour total card count: " ++ String.fromInt s.usersTotalCardCount
                        ]

                Failure errs ->
                    E.column [] <| List.map (\e -> E.text e) errs
    in
    elements



--elements


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
