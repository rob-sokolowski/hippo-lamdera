module Pages.Stories.MathJaxDemo exposing (Model, Msg, page)

import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Gen.Params.Stories.MathJaxDemo exposing (Params)
import Html exposing (Html)
import Html.Attributes as HA
import Json.Encode
import Page
import Pages.Stories.Expression as Expression
import Palette
import Request
import Scripta.API
import Scripta.Language exposing (Language(..))
import Shared
import Utils.Task exposing (send)
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.advanced
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { counter : Int
    }


init : ( Model, Effect Msg )
init =
    ( { counter = 0
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = Render Scripta.API.Msg


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Render scriptaMsg ->
            ( { model | counter = model.counter + 1 }, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Story | MathJax"
    , body = [ el [ width fill, height fill ] (viewElements model) ]
    }


viewElements : Model -> Element Msg
viewElements model =
    row
        [ width (px 1200)
        , height fill
        , padding 5
        , spacing 5
        , centerX
        ]
        [ column
            [ width fill
            , height fill
            , Border.width 1
            , Border.color Palette.black
            ]
            [ E.text "LHS:"
            , mathElements demoText2

            --, viewRenderedCard demoText2 model.counter
            ]
        , column
            [ width fill
            , height fill
            , Border.width 1
            , Border.color Palette.black
            ]
            [ E.text "RHS:"
            , katexElements demoText2
            ]
        ]


katexElements : String -> Element Msg
katexElements sourceText =
    E.html (katexHtml sourceText)


katexHtml : String -> Html Msg
katexHtml sourceText =
    Html.node "math-container"
        []
        [ Expression.compile sourceText ]


mathElements : String -> Element Msg
mathElements content =
    E.html (mathText content)


mathText : String -> Html msg
mathText content =
    Html.node "math-container-2"
        [ HA.property "content" (Json.Encode.string content) ]
        []


demoText =
    """Hi hi hi!!
"""


demoText2 =
    """
Pythagoras sez: $a^2 + b^2 = c^2$.  Extremely cool!

This will be on the test:

$$
\\int_0^1 x^n dx = \\frac{1}{n+ 1}
$$

Study hard!
"""