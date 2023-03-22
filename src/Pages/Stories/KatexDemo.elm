module Pages.Stories.KatexDemo exposing (Model, Msg, page)

import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Gen.Params.Stories.KatexDemo exposing (Params)
import Page
import Palette
import Request
import Scripta.API exposing (DisplaySettings)
import Scripta.Language exposing (Language(..))
import Shared
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.advanced
        { init = init shared
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    {}


init : Shared.Model -> ( Model, Effect Msg )
init shared =
    ( {}
    , Effect.none
    )



-- UPDATE


type Msg
    = Render Scripta.API.Msg


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Render scriptMsg ->
            ( model, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Stories.KatexDemo"
    , body =
        [ el
            [ width fill
            , height fill
            , Background.color Palette.white
            ]
            (viewElements model)
        ]
    }


viewElements : Model -> Element Msg
viewElements model =
    column
        [ centerX
        , centerY
        , width fill
        , height fill
        ]
        [ paragraph [ centerX ] [ text "You should see a math equation below. If not, this test fails!" ]
        , viewScriptaDemo model
        ]


testText =
    """
$$
e^{i \\pi} + 1 = 0
$$

"""


type DisplayMode
    = InlineMathMode
    | DisplayMathMode



--display : String -> Html msg
--display str =
--    Html.div []
--        [ mathText DisplayMathMode str ]
--
--
--inline : String -> Html msg
--inline str =
--    Html.span []
--        [ mathText InlineMathMode str ]
--mathText : DisplayMode -> String -> Html msg
--mathText displayMode str =
--    Html.node "math-text"
--        [ HA.property "display" (Json.Encode.bool (isDisplayMathMode displayMode))
--        , HA.property "content" (Json.Encode.string str)
--        ]
--        []
--isDisplayMathMode : DisplayMode -> Bool
--isDisplayMathMode displayMode =
--    case displayMode of
--        InlineMathMode ->
--            False
--
--        DisplayMathMode ->
--            True


viewScriptaDemo : Model -> Element Msg
viewScriptaDemo model =
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
        [ centerX
        ]
    <|
        (Scripta.API.compile (settings 1) XMarkdownLang testText |> List.map (E.map Render))
