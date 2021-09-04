module Pages.Cards exposing (Model, Msg(..), page)

import Effect exposing (Effect)
import Gen.Params.Cards exposing (Params)
import Page
import Request
import Shared
import View exposing (View)
import Page
import Element exposing (..)
import Element.Region as Region exposing (..)
import Element.Input as Input exposing (..)
import Element.Background as Background exposing (..)
import Element.Border as Border exposing (..)
import Element.Font as Font exposing (..)
import Request exposing (Request)
import View exposing (View)
import Html exposing (Html)
import Api.Card exposing (FlashCard(..), PromptFrequency(..), PlainTextCard, CardId, MarkdownCard)
import Api.User exposing (User, UserId)
import Api.Data exposing (Data(..))
import Page
import Debug exposing (..)
import Shared
import Bridge exposing (ToBackend(..))
import Pages.Settings exposing (Msg(..))
import Lamdera
import Api.Card exposing (CardEnvelope)


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
    {
        selectedOption : SelectedFormRadioOption
        , editorForm : EditorForm
        , cardSubmitStatus : Data CardId
        , user : User
    }


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted FlashCard UserId
    | GotCard (Data CardId)


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorField
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


defaultPlaintextCard = PlainTextCard "" ""

defaultMarkdownCard = MarkdownCard "" "" []


-- UPDATE



update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Updated form_ field newVal ->
            let
                newForm = case form_ of
                    PlainTextForm card ->
                        case field of
                            PlainText_Question ->
                                PlainTextForm {card | question = newVal}
                            PlainText_Answer ->
                                PlainTextForm {card | answer = newVal}
                            _ ->
                                -- smell?
                                PlainTextForm defaultPlaintextCard
                    MarkdownForm card ->
                        case field of
                            Markdown_Question ->
                                MarkdownForm {card | question = newVal}
                            Markdown_Answer ->
                                MarkdownForm {card | answer = newVal}
                            _ ->
                                -- smell?
                                MarkdownForm defaultMarkdownCard
            in
            ({ model
            | editorForm = newForm
            }, Effect.none)            

        ToggledOption selection ->
        -- TODO: We're holding two state variables, `selectedType` and `card`. Is this necessary?
        --       Also, this is a lazy implementation, so state is trampled on every toggle. (I'm OK with this for now)
            let
                (newForm, option) = case selection of
                    MarkdownRadioOption ->
                        (MarkdownForm defaultMarkdownCard, MarkdownRadioOption)
                    PlainTextRadioOption ->
                        (PlainTextForm defaultPlaintextCard, PlainTextRadioOption)
                        
            in
            
            ({model
            | editorForm = newForm
            , selectedOption = option
            }
            , Effect.none)

        Submitted newCard userId ->
            ({model | cardSubmitStatus = Loading}, Effect.fromCmd <| (CreateCard_Cards newCard userId |> Lamdera.sendToBackend))

        GotCard data ->
            case data of
                NotAsked ->
                    ({model | cardSubmitStatus = NotAsked}, Effect.none)
                Loading ->
                    ({model | cardSubmitStatus = Loading}, Effect.none)
                Failure errors ->
                    ({model | cardSubmitStatus = Failure errors}, Effect.none)
                Success cardId ->
                    ({model | cardSubmitStatus = Success cardId}, Effect.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none


-- VIEW
view : User -> Model -> View Msg
view _ model =
    { title = "New Card Editor"
    , body = [layout [] <| viewElements model]
    }


viewElements : Model -> Element Msg
viewElements model =
    Element.column [centerX] [
        viewCardTypeSelector model
        , viewCardForm model.editorForm model.user
        , viewCardSubmitStatus model
    ]


viewCardForm : EditorForm -> User -> Element Msg
viewCardForm form user =
    case form of
        PlainTextForm plainTextCard ->
             el [] (viewPlainTextEditor plainTextCard user.id )
        MarkdownForm markdownCard ->
             el [] (viewMarkdownEditor markdownCard)


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
    Element.column [] [
        Input.radio
        [ spacing 12
        , Background.color grey
        ]
        { selected = Just model.selectedOption
        , onChange = ToggledOption
        , label = Input.labelAbove [ Font.size 14, paddingXY 0 12 ] (Element.text "What type of flash card?")
        , options =
            [ Input.option MarkdownRadioOption (Element.text "Markdown")
            , Input.option PlainTextRadioOption (Element.text "Plain text")
            ]
        }
    ]


viewMarkdownEditor : MarkdownCard -> Element Msg
viewMarkdownEditor card =
    Element.column [] [
        Input.multiline [padding 5]
        {
            onChange = (\text -> Updated (MarkdownForm card) Markdown_Question text)
            , text = card.question
            , placeholder = Just <| Input.placeholder [] (Element.text "Question prompt:")
            , label = Input.labelAbove [] (Element.text "Label above??")
            , spellcheck = True
        }
        , Input.multiline [padding 5]
        {
            onChange = (\text -> Updated (MarkdownForm card) Markdown_Answer text)
            , text = card.answer
            , placeholder = Just <| Input.placeholder [] (Element.text "Answer prompt:")
            , label = Input.labelAbove [] (Element.text "Label above??")
            , spellcheck = True
        }
    ]
    

viewPlainTextEditor : PlainTextCard -> UserId -> Element Msg
viewPlainTextEditor card userId =
    let
        update_ : String -> PlainTextCard
        update_ updatedInput =
            { card | question = updatedInput}
    in
    Element.column
            [ Element.width (px 800)
            , height shrink
            , spacing 36
            , padding 10
            ]
            [ el
                [ 
                    Region.heading 1
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
                , onChange = (\text -> Updated (PlainTextForm card) PlainText_Question text)
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
                , onChange = (\text -> Updated (PlainTextForm card) PlainText_Answer text)
                , label = Input.labelAbove [ Font.size 14 ] (Element.text "Answer prompt:")
                , spellcheck = True
                }
            
            , Input.button
                [ Background.color blue
                , Font.color white
                , Border.color darkBlue
                , paddingXY 32 16
                , Border.rounded 3
                , Element.width fill
                ]
                { onPress = Just <| Submitted (PlainText card) userId
                , label = Element.text "Save card!"
                }
            ]


-- viewCard : CardEnvelope -> Element Msg
-- viewCard card =
--     Element.column [] [
        
--     ]


-- color defs
white =
    Element.rgb 1 1 1


grey =
    Element.rgb 0.9 0.9 0.9


blue =
    Element.rgb 0 0.4 0.7


red =
    Element.rgb 0.8 0 0


darkBlue =
    Element.rgb 0 0 0.8
