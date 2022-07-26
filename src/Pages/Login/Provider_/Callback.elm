module Pages.Login.Provider_.Callback exposing (Model, Msg(..), page)

import Api.Data exposing (Data)
import Api.User exposing (User)
import Auth.Common
import Auth.Flow
import Bridge exposing (..)
import Browser.Navigation as Nav exposing (Key)
import Color
import Effect exposing (Effect)
import Element as E exposing (Element)
import Element.Font as Font
import Gen.Params.Login.Provider_.Callback exposing (Params)
import Gen.Route as Route
import Html exposing (Html)
import Lamdera
import Page
import Request
import Shared
import TypedSvg exposing (circle, svg)
import TypedSvg.Attributes exposing (cx, cy, fill, r, stroke, strokeWidth, viewBox)
import TypedSvg.Core exposing (Svg)
import TypedSvg.Types exposing (Paint(..), px)
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
    E.el
        [ E.height E.fill
        , E.width E.fill
        ]
    <|
        E.row [ E.centerX, E.centerY ]
            [ E.el [ Font.size 24 ] <| E.text "Verifying auth..."
            , E.html circleHtml
            ]


circleHtml : Html msg
circleHtml =
    let
        circle_ : Svg msg
        circle_ =
            circle
                [ cx (px 100)
                , cy (px 100)
                , r (px 30)
                , fill <| Paint Color.blue
                , strokeWidth (px 2)
                , stroke <| Paint <| Color.rgba 0.8 0 0 0.5
                ]
                []
    in
    svg [ viewBox 0 0 100 100 ] [ circle_ ]
