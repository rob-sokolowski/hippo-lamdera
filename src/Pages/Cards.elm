module Pages.Cards exposing (Model, Msg(..), page)

import Api.Card exposing (CardEnvelope, CardId, FlashCard(..), MarkdownCard, PlainTextCard, PromptFrequency(..))
import Api.Data exposing (Data(..))
import Api.User exposing (User, UserId)
import Bridge exposing (ToBackend(..))
import Components.Styling as Styling
import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Gen.Params.Cards exposing (Params)
import Html exposing (Html)
import Lamdera
import Markdown.Option exposing (..)
import Markdown.Render
import Page
import Request exposing (Request)
import Shared
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.protected.advanced
        (\user ->
            { init = init user
            , update = update
            , subscriptions = subscriptions
            , view = view user
            }
        )



-- INIT


type EditorForm
    = PlainTextForm PlainTextCard
    | MarkdownForm MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Data CardId
    , user : User
    }


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted FlashCard UserId
    | GotCard (Data CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type
    EditorField
    -- TODO: I'm unsure if this is normal, or the _ this is a smell
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


init : User -> ( Model, Effect Msg )
init user =
    ( { selectedOption = MarkdownRadioOption
      , editorForm = MarkdownForm defaultMarkdownCard
      , cardSubmitStatus = NotAsked
      , user = user
      }
    , Effect.none
    )


defaultPlaintextCard =
    PlainTextCard "" ""


defaultMarkdownCard =
    MarkdownCard "" (renderMarkdown "") "" (renderMarkdown "") []



-- UPDATE


renderMarkdown : String -> String
renderMarkdown str =
    "Rendered: " ++ str


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Updated form_ field newVal ->
            let
                newForm =
                    case form_ of
                        PlainTextForm card ->
                            case field of
                                PlainText_Question ->
                                    PlainTextForm { card | question = newVal }

                                PlainText_Answer ->
                                    PlainTextForm { card | answer = newVal }

                                _ ->
                                    -- smell?
                                    PlainTextForm defaultPlaintextCard

                        MarkdownForm card ->
                            case field of
                                Markdown_Question ->
                                    MarkdownForm
                                        { card
                                            | question = newVal
                                            , renderedQuestion = renderMarkdown newVal
                                        }

                                Markdown_Answer ->
                                    MarkdownForm
                                        { card
                                            | answer = newVal
                                            , renderedAnswer = renderMarkdown newVal
                                        }

                                _ ->
                                    -- smell?
                                    MarkdownForm defaultMarkdownCard
            in
            ( { model
                | editorForm = newForm
              }
            , Effect.none
            )

        ToggledOption selection ->
            -- TODO: We're holding two state variables, `selectedType` and `card`. Is this necessary?
            --       Also, this is a lazy implementation, so state is trampled on every toggle. (I'm OK with this for now)
            let
                ( newForm, option ) =
                    case selection of
                        MarkdownRadioOption ->
                            ( MarkdownForm defaultMarkdownCard, MarkdownRadioOption )

                        PlainTextRadioOption ->
                            ( PlainTextForm defaultPlaintextCard, PlainTextRadioOption )
            in
            ( { model
                | editorForm = newForm
                , selectedOption = option
              }
            , Effect.none
            )

        Submitted newCard userId ->
            ( { model | cardSubmitStatus = Loading }, Effect.fromCmd <| (CreateCard_Cards newCard userId |> Lamdera.sendToBackend) )

        GotCard data ->
            case data of
                NotAsked ->
                    ( { model | cardSubmitStatus = NotAsked }, Effect.none )

                Loading ->
                    ( { model | cardSubmitStatus = Loading }, Effect.none )

                Failure errors ->
                    ( { model | cardSubmitStatus = Failure errors }, Effect.none )

                Success cardId ->
                    ( { model | cardSubmitStatus = Success cardId }, Effect.none )

        MarkdownMsg _ ->
            ( model, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : User -> Model -> View Msg
view _ model =
    { title = "New Card Editor"
    , body = [ viewElements model ]
    }


viewElements : Model -> Element Msg
viewElements model =
    E.row
        [ padding 0
        , spacing 5
        , height fill
        , width fill
        , Font.size 16
        ]
        [ E.column
            [ Background.color Styling.softGrey
            , E.width <| px 200
            , height fill
            , alignTop
            , centerX
            ]
            [ viewCardTypeSelector model
            , viewCardSubmitStatus model
            , viewCardSubmission model.editorForm model.user
            ]
        , E.column
            [ E.width <| E.minimum 600 fill
            , height fill
            ]
            [ viewCardForm model.editorForm model.user
            ]
        ]


viewCardSubmission : EditorForm -> User -> Element Msg
viewCardSubmission form user =
    let
        onPress_ =
            case form of
                PlainTextForm card ->
                    Just <| Submitted (PlainText card) user.id

                MarkdownForm card ->
                    Just <| Submitted (Markdown card) user.id
    in
    el
        [ E.width fill
        ]
    <|
        Input.button
            [ Background.color Styling.grey
            , Font.bold
            , Border.color Styling.darkBlue
            , Border.width 1
            , padding 10
            , Border.rounded 5
            , E.width fill
            ]
            { onPress = onPress_
            , label = E.text "Submit"
            }


viewCardForm : EditorForm -> User -> Element Msg
viewCardForm form user =
    case form of
        PlainTextForm plainTextCard ->
            el [] (viewPlainTextEditor plainTextCard user.id)

        MarkdownForm markdownCard ->
            el
                [ E.width fill
                , E.height fill
                ]
                (viewMarkdownEditor markdownCard)


viewCardSubmitStatus : Model -> Element Msg
viewCardSubmitStatus model =
    case model.cardSubmitStatus of
        NotAsked ->
            E.none

        Loading ->
            E.text "Loading.."

        Failure errs ->
            E.column [] <| List.map (\e -> E.text e) errs

        Success cardId ->
            E.text <| "Success"


viewCardTypeSelector : Model -> Element Msg
viewCardTypeSelector model =
    E.column
        [ padding 10
        , height fill
        , alignTop
        ]
        [ Input.radio
            [ spacing 10
            , padding 10
            , Background.color Styling.grey
            , alignTop
            ]
            { selected = Just model.selectedOption
            , onChange = ToggledOption
            , label = Input.labelAbove [ paddingXY 0 12 ] (E.text "What type of flash card?")
            , options =
                [ Input.option MarkdownRadioOption (E.text "Markdown")
                , Input.option PlainTextRadioOption (E.text "Plain text")
                ]
            }
        ]


viewRenderedQuestion : MarkdownCard -> Element Msg
viewRenderedQuestion card =
    E.html
        (Markdown.Render.toHtml ExtendedMath card.question |> Html.map MarkdownMsg)


viewRenderedAnswer : MarkdownCard -> Element Msg
viewRenderedAnswer card =
    E.html
        (Markdown.Render.toHtml ExtendedMath card.answer |> Html.map MarkdownMsg)


markdownQuestionPlaceholder =
    Just <| Input.placeholder [] <| E.text """
    Enter Markdown here!
    """


viewMarkdownEditor : MarkdownCard -> Element Msg
viewMarkdownEditor card =
    E.column
        [ padding 0
        , spacing 5
        , height fill
        , width fill
        ]
        [ E.row
            [ padding 10
            , spacing 10
            , Background.color Styling.softGrey
            , height <| fillPortion 5
            , width fill
            ]
            [ Input.multiline
                [ padding 5
                , Border.rounded 10
                , E.width <| E.minimum 400 fill
                , E.height <| E.minimum 200 fill
                ]
                { onChange = \text -> Updated (MarkdownForm card) Markdown_Question text
                , text = card.question
                , placeholder = markdownQuestionPlaceholder
                , label = Input.labelAbove [] <| E.text "Prompt side:"
                , spellcheck = True
                }
            , el
                [ padding 10
                , E.width <| E.minimum 400 fill
                , E.height fill
                , Border.rounded 10
                , Background.color Styling.white
                ]
              <|
                viewRenderedQuestion card
            ]
        , E.row
            [ padding 5
            , spacing 10
            , Background.color Styling.softGrey
            , height <| fillPortion 5
            , width fill
            ]
            [ Input.multiline
                [ padding 5
                , E.width <| E.minimum 400 fill
                , E.height <| E.minimum 200 fill
                ]
                { onChange = \text -> Updated (MarkdownForm card) Markdown_Answer text
                , text = card.answer
                , placeholder = Just <| Input.placeholder [] (E.text "Enter Markdown here!")
                , label = Input.labelAbove [] <| E.text "Answer side:"
                , spellcheck = True
                }
            , el
                [ padding 10
                , E.width <| E.minimum 400 fill
                , E.height <| E.minimum 200 fill
                , Border.rounded 10
                , Background.color Styling.white
                ]
              <|
                viewRenderedAnswer card
            ]
        ]


viewPlainTextEditor : PlainTextCard -> UserId -> Element Msg
viewPlainTextEditor card userId =
    let
        update_ : String -> PlainTextCard
        update_ updatedInput =
            { card | question = updatedInput }
    in
    E.column
        [ E.width (px 800)
        , height shrink
        , spacing 36
        , padding 10
        ]
        [ el
            [ Region.heading 1
            , E.alignLeft
            , Font.size 36
            ]
            (E.text "Add a new flash card:")
        , Input.multiline
            [ height shrink
            , spacing 12
            , padding 6
            ]
            { text = card.question
            , placeholder = Just <| Input.placeholder [] (E.text "Question goes here..")
            , onChange = \text -> Updated (PlainTextForm card) PlainText_Question text
            , label = Input.labelAbove [ Font.size 14 ] (E.text "Flash card prompt")
            , spellcheck = True
            }
        , Input.multiline
            [ height shrink
            , spacing 12
            , padding 6
            ]
            { text = card.answer
            , placeholder = Just <| Input.placeholder [] (E.text "Input answer here")
            , onChange = \text -> Updated (PlainTextForm card) PlainText_Answer text
            , label = Input.labelAbove [ Font.size 14 ] (E.text "Answer prompt:")
            , spellcheck = True
            }
        ]
