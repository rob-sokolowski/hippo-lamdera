module Pages.Cards exposing (Model, Msg, page)

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
import Api.Card exposing (FlashCard(..), PromptFrequency(..), PlainTextCard)
import Api.User exposing (User)
import Api.Data exposing (Data)
import Page
import Debug exposing (..)
import Shared
import Bridge exposing (ToBackend(..))
import Pages.Settings exposing (Msg(..))
import Lamdera


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
-- protected user eventually goes here?? https://raw.githubusercontent.com/rob-sokolowski-git-org/hippo-lamdera/5a2af06c72117101d121806ec1ecdb0700450e58/src/Pages/Cards.elm
    Page.advanced
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT

type FormType = 
    PlainTextCardType 

type alias Model =
    {
        selectedType : FormType
        , card : FlashCard
    }


type Msg
    = Updated PlainTextCard PlainTextCardFormField String
    | SelectedFormType FormType
    | Submitted FlashCard


type PlainTextCardFormField
    = QuestionField
    | AnswerField



init : ( Model, Effect Msg )
init =
    ( { selectedType = PlainTextCardType
        , card = FlashCardPlainText (PlainTextCard "" "" Immediately)
      }
    , Effect.none
    )



-- UPDATE



update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Updated card field val ->
                case field of
                    QuestionField ->
                        let
                            newCard = {card | question = val}
                        in
                        ({ model | card = FlashCardPlainText newCard}, Effect.none)
                    AnswerField ->
                        let                        
                            newCard = {card | answer = val}
                        in
                        ({ model | card = FlashCardPlainText newCard}, Effect.none)
        SelectedFormType newSelection ->
            ({model | selectedType = newSelection}, Effect.none)
        Submitted newCard ->
            (model, Effect.fromCmd <| (CreateCard_Cards newCard |> Lamdera.sendToBackend))



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW

-- TODO: see above tree for this: view : User -> Model -> View Msg for auth?
view : Model -> View Msg
view model =
    { title = "Title string for cards"
    , body = [layout [] <| viewElements model]    }


viewElements : Model -> Element Msg
viewElements model =
    let
        formWrapper =  Element.column [centerX, padding 10, spacing 10] [Element.text "Hello!!!!"]
    in

    case model.card of
        FlashCardPlainText card ->
             el [centerX] (viewPlainTextCardForm (card, model.selectedType) )


viewPlainTextCardForm : (PlainTextCard, FormType) -> Element Msg
viewPlainTextCardForm (card, selectedFormType) =
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
                (Element.text "Welcome to the new card editor!")
            , Input.radio
                [ spacing 12
                , Background.color grey
                ]
                { selected = Just selectedFormType
                , onChange = SelectedFormType
                , label = Input.labelAbove [ Font.size 14, paddingXY 0 12 ] (Element.text "What type of flash card?")
                , options =
                    [ Input.option PlainTextCardType (Element.text "Plain text card")
                    ]
                }
            , Input.multiline
                [ height shrink
                , spacing 12

                , padding 6
                ]
                { text = card.question
                , placeholder = Nothing
                , onChange = Updated card QuestionField
                , label = Input.labelAbove [ Font.size 14 ] (Element.text "Flash card prompt")
                , spellcheck = True
                }

            , Input.multiline
                [ height shrink
                , spacing 12
                , padding 6
                ]
                { text = card.answer
                , placeholder = Nothing
                , onChange = Updated card AnswerField
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
                { onPress = Nothing
                , label = Element.text "Save card!"
                }

            ]



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
