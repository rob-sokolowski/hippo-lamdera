module Pages.Cards exposing (view)


import Element exposing (..)
import Element.Region as Region exposing (..)
import Element.Input as Input exposing (..)
import Element.Background as Background exposing (..)
import Element.Border as Border exposing (..)
import Element.Font as Font exposing (..)
import View exposing (View)
import Html exposing (Html)
import Api.Card exposing (FlashCard(..))
import Evergreen.V3.Api.Card exposing (PlainTextCard)


type Form = 
    PlainTextCardForm PlainTextCard 

type alias Model =
    {
        form : Form
    }


type Msg
    = Update Form


view : Model ->  { title : String, body : List (Html Msg) }
view model =
    { title = "Title string for cards"
    , body = [layout [] <| viewElements model]    }


viewElements : Model -> Element Msg
viewElements model =
    let
        formWrapper =  Element.column [centerX, padding 10, spacing 10] [Element.text "Hello!!!!"]
    in

    case model.form of
        PlainTextCardForm plainTextcard ->
             el [] (viewPlainTextCardForm plainTextcard)




viewPlainTextCardForm : PlainTextCard -> Element Msg
viewPlainTextCardForm card =
    let
        update_ : String -> PlainTextCard
        update_ updatedInput =
            { card | question = updatedInput}
        
    in
    Element.column
            [ Element.width (px 800)
            , height shrink
            , centerY
            , centerX
            , spacing 36
            , padding 10
            ]
            [ el
                [ Region.heading 1
                , Element.alignLeft
                , Font.size 36
                ]
                (Element.text "Welcome to the Stylish Elephants Lunch Emporium")
            -- , Input.radio
            --     [ spacing 12
            --     , Background.color grey
            --     ]
            --     { selected = Just form.selectedCardVariant
            --     , onChange = updateForm
            --     , label = Input.labelAbove [ Font.size 14, paddingXY 0 12 ] (Element.text "What type of flash card?")
            --     , options =
            --         [ Input.option PlainTextCard (Element.text "Plain text card")
            --         ]
            --     }



            -- , Input.multiline
            --     [ height shrink
            --     , spacing 12

            --     -- , padding 6
            --     ]
            --     { text = card.question
            --     , placeholder = Just (Input.placeholder [] (Element.text "Extra hot sauce?\n\n\nYes pls"))
            --     , onChange = update_
            --     , label = Input.labelAbove [ Font.size 14 ] (Element.text "Leave a comment!")
            --     , spellcheck = False
            --     }
            
            
            -- , Input.button
            --     [ Background.color blue
            --     , Font.color white
            --     , Border.color darkBlue
            --     , paddingXY 32 16
            --     , Border.rounded 3
            --     , Element.width fill
            --     ]
            --     { onPress = Nothing
            --     , label = Element.text "Place your lunch order!"
            --     }
            ]



-- color defs
white =
    Element.rgb 1 1 1


grey =
    Element.rgb 0.9 0.9 0.9


blue =
    Element.rgb 0 0 0.8


red =
    Element.rgb 0.8 0 0


darkBlue =
    Element.rgb 0 0 0.9