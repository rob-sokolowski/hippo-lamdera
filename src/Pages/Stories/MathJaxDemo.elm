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
import Palette
import Request
import Scripta.API
import Scripta.Language exposing (Language(..))
import Shared
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
    {}


init : ( Model, Effect Msg )
init =
    ( {}, Effect.none )



-- UPDATE


type Msg
    = Render Scripta.API.Msg


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Render scriptaMsg ->
            ( model, Effect.none )



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
    column
        [ width (px 1200)
        , height fill
        , centerX
        , centerY
        , Border.width 1
        , Border.color Palette.blue
        ]
        [ el [ centerX ] <| E.text "MathJax is awesome!"
        , el [ centerX, centerY ] (E.html (mathText demoText))
        ]


demoText =
    """
$$
\\int_\\infty^\\infty e^{-x^2} dx = \\sqrt\\pi
$$
"""


mathText : String -> Html msg
mathText content =
    Html.node "math-text"
        [ HA.property "content" (Json.Encode.string content) ]
        []


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
