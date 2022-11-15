module Pages.Study exposing (Model, Msg(..), page)

import Api.Card exposing (CardEnvelope, CardId, FlashCard(..), Grade(..), MarkdownCard, PlainTextCard, StudySessionSummary)
import Api.Data as Data exposing (..)
import Api.User exposing (User)
import Bridge exposing (ToBackend(..), sendToBackend)
import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Gen.Params.Study exposing (Params)
import Lamdera
import List exposing (..)
import Page
import Palette
import Request
import Scripta.API
import Scripta.Language exposing (Language(..))
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
    | Render Scripta.API.Msg


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

        Render _ ->
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
                            [ Background.color Palette.darkCharcoal
                            , Font.color Palette.lightBlue
                            , Border.color Palette.lightGrey
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
                                    el
                                        []
                                        (viewPlainTextFlashcardPrompt card_ env.id model.promptStatus)

                                Markdown card_ ->
                                    el
                                        [ width fill
                                        , height <| E.maximum 600 <| E.minimum 400 fill
                                        , centerY
                                        , centerX
                                        ]
                                        (viewMarkdownFlashcardPrompt card_ env.id model.promptStatus 0)

                        Nothing ->
                            E.text "You have studied all your cards!"

        summaryText : String
        summaryText =
            case model.cardDataFetch of
                NotAsked ->
                    " "

                Loading ->
                    " "

                Failure errs ->
                    " "

                Success cards ->
                    let
                        nCards =
                            List.length cards

                        currentCardText : String
                        currentCardText =
                            case List.head cards of
                                Nothing ->
                                    " "

                                Just card ->
                                    "DEBUG: Selected cardId=" ++ String.fromInt card.id

                        cardCopy =
                            if nCards == 1 then
                                "card"

                            else
                                "cards"
                    in
                    "You have " ++ String.fromInt nCards ++ " " ++ cardCopy ++ " due for study.     " ++ currentCardText
    in
    column
        [ width fill
        , height fill
        , spacing 15
        , padding 10
        ]
        [ el
            [ width fill
            , Background.color Palette.softGrey
            , height <| px 50
            ]
            (el [ centerY, alignLeft ] <| text summaryText)
        , el
            [ width fill
            , height fill
            , Background.color Palette.softGrey
            ]
            viewPrompt
        ]


viewMarkdownFlashcardPrompt : MarkdownCard -> CardId -> PromptStatus -> Int -> Element Msg
viewMarkdownFlashcardPrompt card cid ps count =
    case ps of
        Idle ->
            E.none

        QuestionPrompted ->
            E.row
                [ Background.color Palette.softGrey
                , spacing 5
                , height fill
                , centerX
                ]
                [ E.column
                    [ spacing 5
                    , height fill
                    ]
                    [ el
                        [ Background.color Palette.white
                        , Border.rounded 10
                        , padding 10
                        , E.width <| E.minimum 400 <| E.maximum 600 fill
                        , E.height <| E.minimum 300 fill
                        , clip
                        ]
                      <|
                        viewRenderedQuestion card count
                    , el
                        [ E.width fill
                        , E.height <| E.minimum 60 <| E.maximum 100 fill
                        ]
                        E.none
                    ]
                , E.column
                    [ spacing 5
                    , height fill
                    ]
                    [ el
                        [ Background.color Palette.white
                        , Border.rounded 10
                        , padding 10
                        , E.width <| E.minimum 400 <| E.maximum 600 fill
                        , E.height <| E.minimum 300 fill
                        ]
                      <|
                        Input.button
                            [ Background.color Palette.medGrey
                            , Font.color Palette.black
                            , Font.bold
                            , Border.color Palette.dimGrey
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
                    , E.el
                        [ spacing 10
                        , E.width fill
                        , E.height <| E.minimum 60 <| E.maximum 100 fill
                        , Font.size 36
                        ]
                        E.none
                    ]
                ]

        AnswerRevealed ->
            E.row
                [ Border.width 0
                , Border.color Palette.darkCharcoal
                , Background.color Palette.softGrey
                , spacing 5
                , height fill
                , centerX
                ]
                [ E.column
                    [ spacing 5
                    , height fill
                    ]
                    [ el
                        [ Background.color Palette.white
                        , Border.rounded 10
                        , padding 10
                        , E.width <| E.minimum 400 <| E.maximum 600 fill
                        , E.height <| E.minimum 300 fill
                        , clip
                        ]
                      <|
                        viewRenderedCard card.question count
                    , el
                        [ E.width fill
                        , E.height <| E.minimum 60 <| E.maximum 100 fill
                        ]
                        E.none
                    , el [ alignRight, centerY ] <| E.text ("Tag: " ++ Maybe.withDefault "" card.tag)
                    ]
                , E.column
                    [ spacing 5
                    , height fill
                    ]
                    [ el
                        [ Background.color Palette.white
                        , Border.rounded 10
                        , padding 10
                        , E.width <| E.minimum 400 <| E.maximum 600 fill
                        , E.height <| E.minimum 300 fill
                        , clip
                        ]
                      <|
                        viewRenderedCard card.answer count
                    , E.row
                        [ spacing 10
                        , E.width fill
                        , E.height <| E.minimum 60 <| E.maximum 100 fill
                        , Font.size 36
                        ]
                        [ Input.button
                            [ Background.color Palette.medGrey
                            , Font.color Palette.black
                            , Font.bold
                            , Border.color Palette.black
                            , Border.rounded 5
                            , E.width fill
                            , E.height fill
                            ]
                            { onPress = Just <| UserSelfGrade cid Incorrect
                            , label = el [ centerX ] <| E.text "X"
                            }
                        , Input.button
                            [ Background.color Palette.medGrey
                            , Font.color Palette.black
                            , Border.color Palette.lightGrey
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


viewRenderedQuestion : MarkdownCard -> Int -> Element Msg
viewRenderedQuestion card count =
    let
        settings : a -> { windowWidth : number, counter : a, selectedId : String, selectedSlug : Maybe b, scale : Float }
        settings counter =
            { windowWidth = 500
            , counter = counter
            , selectedId = "--"
            , selectedSlug = Nothing
            , scale = 0.8
            }

        questionText : String
        questionText =
            card.question
    in
    column
        []
        (Scripta.API.compile (settings count) XMarkdownLang questionText |> List.map (E.map Render))


viewRenderedCard : String -> Int -> Element Msg
viewRenderedCard text count =
    let
        settings : a -> { windowWidth : number, counter : a, selectedId : String, selectedSlug : Maybe b, scale : Float }
        settings counter =
            { windowWidth = 500
            , counter = counter
            , selectedId = "--"
            , selectedSlug = Nothing
            , scale = 0.8
            }
    in
    column
        []
        (Scripta.API.compile (settings count) XMarkdownLang text |> List.map (E.map Render))


viewPlainTextFlashcardPrompt : PlainTextCard -> CardId -> PromptStatus -> Element Msg
viewPlainTextFlashcardPrompt card cid ps =
    case ps of
        Idle ->
            E.none

        QuestionPrompted ->
            E.column
                [ padding 10
                , spacing 20
                , centerX
                ]
                [ E.text card.answer
                , E.row [ spacing 10 ]
                    [ Input.button
                        [ Background.color Palette.darkCharcoal
                        , Font.color Palette.lightBlue
                        , Border.color Palette.lightGrey
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
                        [ Background.color Palette.darkCharcoal
                        , Font.color Palette.lightBlue
                        , Border.color Palette.lightGrey
                        , paddingXY 32 16
                        , Border.rounded 3
                        , E.width fill
                        ]
                        { onPress = Just <| UserSelfGrade cid Incorrect
                        , label = E.text "X"
                        }
                    , Input.button
                        [ Background.color Palette.darkCharcoal
                        , Font.color Palette.lightBlue
                        , Border.color Palette.lightGrey
                        , paddingXY 32 16
                        , Border.rounded 3
                        , E.width fill
                        ]
                        { onPress = Just <| UserSelfGrade cid Correct
                        , label = E.text "✔"
                        }
                    ]
                ]


viewStudySessionSummary : Data StudySessionSummary -> Element Msg
viewStudySessionSummary summary =
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


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed
