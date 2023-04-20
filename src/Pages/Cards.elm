module Pages.Cards exposing (Model, Msg(..), page)

import Api.Card exposing (CardEnvelope, CardId, FlashCard(..), MarkdownCard, PromptFrequency(..))
import Api.Data exposing (Data(..))
import Api.User exposing (User, UserId)
import Bridge exposing (ToBackend(..))
import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Element.Input as Input
import Element.Region as Region
import Gen.Params.Cards exposing (Params)
import Lamdera
import Page
import Palette
import Request exposing (Request)
import Scripta.API exposing (DisplaySettings)
import Scripta.Language exposing (Language(..))
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
    = MarkdownForm MarkdownCard
    | AiAssistedMarkdownForm (List MarkdownCard)


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Data CardId
    , user : User
    , count : Int
    }


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted FlashCard UserId
    | GotCard (Data CardId)
    | Render Scripta.API.Msg
    | Noop String


type SelectedFormRadioOption
    = MarkdownRadioOption
    | AiAssistRadioOption


type EditorField
    = Markdown_Question
    | Markdown_Answer
    | Markdown_Tag


init : User -> ( Model, Effect Msg )
init user =
    ( { selectedOption = MarkdownRadioOption
      , editorForm = MarkdownForm defaultMarkdownCard
      , cardSubmitStatus = NotAsked
      , user = user
      , count = 0
      }
    , Effect.none
    )


defaultMarkdownCard =
    MarkdownCard "" "" Nothing



-- UPDATE


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Noop _ ->
            ( model, Effect.none )

        Render _ ->
            ( model, Effect.none )

        FormUpdated form field str ->
            let
                newForm =
                    case form of
                        MarkdownForm card ->
                            case field of
                                Markdown_Question ->
                                    MarkdownForm { card | question = str }

                                Markdown_Answer ->
                                    MarkdownForm { card | answer = str }

                                Markdown_Tag ->
                                    MarkdownForm { card | tag = Just str }

                        AiAssistedMarkdownForm cards ->
                            case field of
                                Markdown_Question ->
                                    AiAssistedMarkdownForm (List.map (\card -> { card | question = str }) cards)

                                Markdown_Answer ->
                                    AiAssistedMarkdownForm (List.map (\card -> { card | answer = str }) cards)

                                Markdown_Tag ->
                                    AiAssistedMarkdownForm (List.map (\card -> { card | tag = Just str }) cards)
            in
            ( { model
                | editorForm = newForm
                , count = model.count + 1
              }
            , Effect.none
            )

        ToggledOption selection ->
            let
                ( newForm, option ) =
                    case selection of
                        MarkdownRadioOption ->
                            ( MarkdownForm defaultMarkdownCard, MarkdownRadioOption )

                        AiAssistRadioOption ->
                            ( AiAssistedMarkdownForm [ defaultMarkdownCard ], AiAssistRadioOption )
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
                    ( { model
                        | cardSubmitStatus = Success cardId
                        , editorForm =
                            case model.editorForm of
                                MarkdownForm _ ->
                                    MarkdownForm
                                        { question = ""
                                        , answer = ""
                                        , tag = Nothing
                                        }

                                AiAssistedMarkdownForm _ ->
                                    AiAssistedMarkdownForm
                                        [ { question = ""
                                          , answer = ""
                                          , tag = Nothing
                                          }
                                        ]
                      }
                    , Effect.none
                    )



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
            [ Background.color Palette.softGrey
            , E.width <| px 200
            , height fill
            , alignTop
            , centerX
            ]
            [ viewCardTypeSelector model
            , viewCardSubmitStatus model
            , viewTagField model.editorForm
            , viewCardSubmission model.editorForm model.user
            ]
        , E.column
            [ E.width <| E.minimum 600 fill
            , height fill
            ]
            [ viewCardForm model.editorForm model.user model.count
            ]
        ]


viewTagField : EditorForm -> Element Msg
viewTagField form =
    let
        ( onChange, tagDisplayText ) =
            case form of
                MarkdownForm card ->
                    ( FormUpdated (MarkdownForm card) Markdown_Tag, Maybe.withDefault "" card.tag )

                AiAssistedMarkdownForm markdownCards ->
                    -- TODO: I think this should one tag per set of cards..
                    ( Noop, "TODO: Implement this" )
    in
    el
        [ E.width fill
        ]
    <|
        Input.text
            [ Background.color Palette.white
            , Border.width 1
            , padding 10
            , Border.rounded 5
            , E.width fill
            ]
            { onChange = onChange
            , text = tagDisplayText
            , placeholder = Nothing
            , label = Input.labelLeft [] (E.text "Tag: ")
            }


viewCardSubmission : EditorForm -> User -> Element Msg
viewCardSubmission form user =
    let
        onPress_ =
            case form of
                MarkdownForm card ->
                    Just <| Submitted (Markdown card) user.id

                AiAssistedMarkdownForm markdownCards ->
                    -- TODO: batch upload
                    Nothing
    in
    el
        [ E.width fill
        ]
    <|
        Input.button
            [ Background.color Palette.grey
            , Font.bold
            , Border.color Palette.darkBlue
            , Border.width 1
            , padding 10
            , Border.rounded 5
            , E.width fill
            ]
            { onPress = onPress_
            , label = E.text "Submit"
            }


viewCardForm : EditorForm -> User -> Int -> Element Msg
viewCardForm form user count =
    case form of
        MarkdownForm markdownCard ->
            el
                [ E.width fill
                , E.height fill
                ]
                (viewMarkdownEditor markdownCard count)

        AiAssistedMarkdownForm markdownCards ->
            let
                markdownCard =
                    List.head markdownCards
            in
            case markdownCard of
                -- TODO: actual multi card form
                Nothing ->
                    E.none

                Just markdownCard_ ->
                    el
                        [ E.width fill
                        , E.height fill
                        ]
                        (viewMarkdownEditor markdownCard_ count)


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
            , Background.color Palette.grey
            , alignTop
            ]
            { selected = Just model.selectedOption
            , onChange = ToggledOption
            , label = Input.labelAbove [ paddingXY 0 12 ] (E.text "What type of flash card?")
            , options =
                [ Input.option MarkdownRadioOption (E.text "Markdown")
                ]
            }
        ]


viewRenderedCard : String -> Int -> Element Msg
viewRenderedCard text count =
    let
        settings : Int -> DisplaySettings
        settings counter =
            { windowWidth = 500
            , counter = counter
            , selectedId = "--"
            , selectedSlug = Nothing
            , scale = 0.8
            , longEquationLimit = 100.0
            }
    in
    column
        []
        (Scripta.API.compile (settings count) XMarkdownLang text |> List.map (E.map Render))


markdownQuestionPlaceholder =
    Just <| Input.placeholder [] <| E.text """
    Enter Markdown here!
    """


viewMarkdownEditor : MarkdownCard -> Int -> Element Msg
viewMarkdownEditor card count =
    E.column
        [ padding 0
        , spacing 5
        , height fill
        , width fill
        ]
        [ E.row
            [ padding 10
            , spacing 10
            , Background.color Palette.softGrey
            , height <| fillPortion 5
            , width fill
            ]
            [ Input.multiline
                [ padding 5
                , Border.rounded 10
                , E.width <| E.minimum 400 fill
                , E.height <| E.minimum 200 fill
                ]
                { onChange = \text -> FormUpdated (MarkdownForm card) Markdown_Question text
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
                , Background.color Palette.white
                ]
              <|
                viewRenderedCard card.question count
            ]
        , E.row
            [ padding 5
            , spacing 10
            , Background.color Palette.softGrey
            , height <| fillPortion 5
            , width fill
            ]
            [ Input.multiline
                [ padding 5
                , E.width <| E.minimum 400 fill
                , E.height <| E.minimum 200 fill
                ]
                { onChange = \text -> FormUpdated (MarkdownForm card) Markdown_Answer text
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
                , Background.color Palette.white
                ]
              <|
                viewRenderedCard card.answer count
            ]
        ]
