module Pages.Login.Provider_.Callback exposing (Model, Msg(..), page)

import Api.Data exposing (Data)
import Api.User exposing (User)
import Auth.Common
import Auth.Flow
import Bridge exposing (..)
import Browser.Navigation as Nav exposing (Key)
import Color
import Components.Styling as Styling
import Effect exposing (Effect)
import Element as E exposing (Element)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Gen.Params.Login.Provider_.Callback exposing (Params)
import Gen.Route as Route
import Html exposing (Html)
import Lamdera
import Page
import Request
import Shared
import TypedSvg as S exposing (circle, svg)
import TypedSvg.Attributes as SA exposing (cx, cy, fill, height, r, rx, ry, stroke, strokeWidth, viewBox, width, x, y)
import TypedSvg.Core as SC exposing (Svg)
import TypedSvg.Types as ST exposing (Paint(..), px)
import Url exposing (Url)
import Utils.Route
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.advanced
        { init = init req
        , update = update req
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { authFlow : Auth.Common.Flow
    , authRedirectBaseUrl : Url
    }


init : Request.With Params -> ( Model, Effect Msg )
init req =
    let
        model =
            { authFlow = Auth.Common.Idle
            , authRedirectBaseUrl = { url | query = Nothing, fragment = Nothing }
            }

        url =
            req.url

        -- TODO: This is a todo from Mario's code
        --onFrontendCallbackInit model_ methodId origin navigationKey toBackendFn =
        --    Debug.todo "onFrontendCallbackInit"
        ( authM, authCmd ) =
            Auth.Flow.init model
                req.params.provider
                url
                req.key
                (\msg -> Lamdera.sendToBackend (AuthToBackend msg))
    in
    ( authM
    , Effect.fromCmd authCmd
    )



-- UPDATE


type Msg
    = GotUser (Data User)


update : Request.With Params -> Msg -> Model -> ( Model, Effect Msg )
update req msg model =
    case msg of
        GotUser user ->
            case Api.Data.toMaybe user of
                Just user_ ->
                    ( model
                    , Effect.batch
                        [ Effect.fromCmd (Utils.Route.navigate req.key Route.Home_)
                        , Effect.fromShared (Shared.SignedInUser user_)
                        ]
                    )

                Nothing ->
                    ( model
                    , Effect.none
                    )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Callback"
    , body =
        [ elements model ]
    }


elements : Model -> Element Msg
elements _ =
    E.row
        [ E.centerX
        , E.centerY
        , E.height E.fill
        , E.width (E.maximum 400 E.fill)
        ]
        [ E.el [ Font.size 24, E.centerY ] <| E.text "Verifying auth..."
        , svgElement { minX = 0, minY = 0, height = 50, width = 50 } spinner
        ]


svgElement : SvgViewBox -> List (Svg Msg) -> Element Msg
svgElement viewBox_ svgs =
    E.el
        [ E.width <| E.px (round viewBox_.width)
        , E.height <| E.px (round viewBox_.height)

        --, centerX
        ]
    <|
        E.html (svg [ SA.viewBox viewBox_.minX viewBox_.minY viewBox_.width viewBox_.height ] svgs)


type alias SvgViewBox =
    { minX : Float
    , minY : Float
    , width : Float
    , height : Float
    }


spinner : List (Svg Msg)
spinner =
    [ circle
        [ cx (px 20)
        , cy (px 20)
        , r (px 15)
        , fill <| Paint <| Color.rgb255 0x1F 0xA3 0xE0
        , strokeWidth (px 0)
        , stroke <| Paint <| Color.rgb255 0x18 0x7F 0xAF
        ]
        []
    , circle
        [ cx (px 20)
        , cy (px 20)
        , r (px (15 * 0.75))
        , fill <| Paint <| Color.rgba 1.0 1.0 1.0 1.0
        , strokeWidth (px 0)
        , stroke <| Paint <| Color.rgb255 0x18 0x7F 0xAF
        ]
        []
    , circle
        [ cx (px 10)
        , cy (px 10)
        , r (px 7)
        , fill <| Paint <| Color.rgb255 0x18 0x7F 0xAF
        , strokeWidth (px 1)
        , stroke <| Paint <| Color.rgb255 0x18 0x7F 0xAF
        ]
        []
    ]
