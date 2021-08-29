module Pages.Home_ exposing (Model, Msg(..), page)

import Api.Data exposing (Data)
import Api.User exposing (User)
import Bridge exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, classList)
import Html.Events as Events
import Page
import Request exposing (Request)
import Shared
import Utils.Maybe
import View exposing (View)


page : Shared.Model -> Request -> Page.With Model Msg
page shared _ =
    Page.element
        { init = init shared
        , update = update shared
        , subscriptions = subscriptions
        , view = view shared
        }



-- INIT


type alias Model =
    { tab : Tab
    }


type Tab =
    Global



init : Shared.Model -> ( Model, Cmd Msg )
init shared =
    let
        model : Model
        model = Model Global
    in
    ( model
    , Cmd.none
    )




-- UPDATE


type Msg
    = Noop


type alias Tag =
    String


update : Shared.Model -> Msg -> Model -> ( Model, Cmd Msg )
update shared msg model =
    case msg of
       Noop ->
            (model, Cmd.none)
            

subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Shared.Model -> Model -> View Msg
view shared model =
    { title = ""
    , body =
        [ div [ class "home-page" ]
            [ div [ class "banner" ]
                [ div [ class "container" ]
                    [ h1 [ class "logo-font" ] [ text "hippo" ]
                    , p [] [ text "flash cards" ]
                    ]
                ]
            
            ]
        ]
    }

