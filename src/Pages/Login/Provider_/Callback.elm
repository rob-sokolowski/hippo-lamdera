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
import Element as E exposing (Attribute, Element)
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
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Animated as Animated
import Simple.Animation.Property as P
import Url exposing (Url)
import Utils exposing (animatedEl)
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
        , animatedEl rotationLoop [] spinner
        ]


rotationLoop : Animation
rotationLoop =
    Animation.steps
        { startAt = [ P.rotate 0 ]
        , options = [ Animation.loop ]
        }
        [ Animation.step 1000 [ P.rotate 360 ]
        ]


spinner : Element msg
spinner =
    E.el
        [ E.width (E.px 30)
        , E.height (E.px 30)
        , Background.color Styling.white
        , Border.rounded 25
        , Border.color Styling.blue
        , Border.width 3
        ]
        (E.el
            [ E.width (E.px 10)
            , E.height (E.px 10)
            , Background.color Styling.blue
            , Border.rounded 10
            , Border.color Styling.blue
            , Border.width 3
            , E.moveUp 5
            ]
            E.none
        )
