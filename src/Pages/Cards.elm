module Pages.Cards exposing (Model, Msg(..), page)

import Api.Card exposing (CardEnvelope, CardId, FlashCard(..), MarkdownCard, PlainTextCard, PromptFrequency(..))
import Api.Data exposing (Data(..))
import Api.User exposing (User, UserId)
import Bridge exposing (ToBackend(..))
import Components.Styling as S
import Effect exposing (Effect)
import Element exposing (..)
import Element.Background as Background exposing (..)
import Element.Border as Border exposing (..)
import Element.Font as Font exposing (..)
import Element.Input as Input exposing (..)
import Element.Region as Region exposing (..)
import Gen.Params.Cards exposing (Params)
import Html exposing (Html)
import Lamdera
import Markdown.Option exposing (..)
import Markdown.Render
import Page
import Pages.Settings exposing (Msg(..))
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
    , body = [ layout [ Element.width fill, height fill ] <| viewElements model ]
    }


viewElements : Model -> Element Msg
viewElements model =
    Element.row
        [ padding 20

        -- , height fill
        , Font.size 16
        ]
        [ Element.column
            [ Background.color S.softGrey
            , Element.width <| px 200
            , padding 10
            , spacing 10
            ]
            [ viewCardTypeSelector model
            , viewCardSubmission model.editorForm model.user
            , viewCardSubmitStatus model
            ]
        , Element.column
            [ padding 10
            , Border.width 2
            , Border.color S.blue
            , Element.width <| Element.minimum 600 fill
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
        [ Element.width fill
        ]
    <|
        Input.button
            [ Background.color S.grey
            , Font.bold
            , Border.color S.darkBlue
            , Border.width 1
            , padding 10
            , Border.rounded 5
            , Element.width fill
            ]
            { onPress = onPress_
            , label = Element.text "Submit"
            }


viewCardForm : EditorForm -> User -> Element Msg
viewCardForm form user =
    case form of
        PlainTextForm plainTextCard ->
            el [] (viewPlainTextEditor plainTextCard user.id)

        MarkdownForm markdownCard ->
            el
                [ Element.width fill

                -- , Element.height fill
                ]
                (viewMarkdownEditor markdownCard)


viewCardSubmitStatus : Model -> Element Msg
viewCardSubmitStatus model =
    case model.cardSubmitStatus of
        NotAsked ->
            Element.none

        Loading ->
            Element.text "Loading.."

        Failure errs ->
            Element.column [] <| List.map (\e -> Element.text e) errs

        Success cardId ->
            Element.text <| "Success, there are " ++ String.fromInt cardId ++ " cards"


viewCardTypeSelector : Model -> Element Msg
viewCardTypeSelector model =
    Element.column
        [ padding 10
        ]
        [ Input.radio
            [ spacing 10
            , padding 10
            , Background.color S.grey
            ]
            { selected = Just model.selectedOption
            , onChange = ToggledOption
            , label = Input.labelAbove [ paddingXY 0 12 ] (Element.text "What type of flash card?")
            , options =
                [ Input.option MarkdownRadioOption (Element.text "Markdown")
                , Input.option PlainTextRadioOption (Element.text "Plain text")
                ]
            }
        ]


viewRenderedQuestion : MarkdownCard -> Element Msg
viewRenderedQuestion card =
    Element.html
        (Markdown.Render.toHtml ExtendedMath card.question |> Html.map MarkdownMsg)


viewRenderedAnswer : MarkdownCard -> Element Msg
viewRenderedAnswer card =
    Element.html
        (Markdown.Render.toHtml ExtendedMath card.answer |> Html.map MarkdownMsg)


markdownQuestionPlaceholder =
    Just <| Input.placeholder [] <| Element.text """
    Enter Markdown here!
    """


viewMarkdownEditor : MarkdownCard -> Element Msg
viewMarkdownEditor card =
    Element.column
        [ padding 10
        , spacing 10
        ]
        [ Element.row
            [ padding 10
            , spacing 10
            , Background.color S.softGrey
            ]
            [ Input.multiline
                [ padding 5
                , Border.rounded 10
                , Element.width <| px 400
                , Element.height <| Element.minimum 200 fill
                ]
                { onChange = \text -> Updated (MarkdownForm card) Markdown_Question text
                , text = card.question
                , placeholder = markdownQuestionPlaceholder
                , label = Input.labelAbove [] <| Element.text "Prompt side:"
                , spellcheck = True
                }
            , el
                [ padding 10
                , Element.width <| Element.px 400
                , Element.height fill
                , Border.rounded 10
                , Background.color S.white
                ]
              <|
                viewRenderedQuestion card
            ]
        , Element.row
            [ padding 5
            , spacing 10
            , Background.color S.softGrey
            ]
            [ Input.multiline
                [ padding 5
                , Element.width <| px 400
                , Element.height <| Element.minimum 200 fill
                ]
                { onChange = \text -> Updated (MarkdownForm card) Markdown_Answer text
                , text = card.answer
                , placeholder = Just <| Input.placeholder [] (Element.text "Enter Markdown here!")
                , label = Input.labelAbove [] <| Element.text "Answer side:"
                , spellcheck = True
                }
            , el
                [ padding 10
                , Element.width <| px 400
                , Element.height <| Element.minimum 200 fill
                , Border.rounded 10
                , Background.color S.white
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
    Element.column
        [ Element.width (px 800)
        , height shrink
        , spacing 36
        , padding 10
        ]
        [ el
            [ Region.heading 1
            , Element.alignLeft
            , Font.size 36
            ]
            (Element.text "Add a new flash card:")
        , Input.multiline
            [ height shrink
            , spacing 12
            , padding 6
            ]
            { text = card.question
            , placeholder = Just <| Input.placeholder [] (Element.text "Question goes here..")
            , onChange = \text -> Updated (PlainTextForm card) PlainText_Question text
            , label = Input.labelAbove [ Font.size 14 ] (Element.text "Flash card prompt")
            , spellcheck = True
            }
        , Input.multiline
            [ height shrink
            , spacing 12
            , padding 6
            ]
            { text = card.answer
            , placeholder = Just <| Input.placeholder [] (Element.text "Input answer here")
            , onChange = \text -> Updated (PlainTextForm card) PlainText_Answer text
            , label = Input.labelAbove [ Font.size 14 ] (Element.text "Answer prompt:")
            , spellcheck = True
            }
        ]



-- viewCard : CardEnvelope -> Element Msg
-- viewCard card =
--     Element.column [] [
--     ]
-- color defs
