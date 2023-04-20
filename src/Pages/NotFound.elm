module Pages.NotFound exposing (Model, Msg(..), page)

import Effect exposing (Effect)
import Element as E exposing (..)
import Gen.Params.NotFound exposing (Params)
import Page
import Request
import Shared
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.advanced
        { init = init ""
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { requestedRoute : String
    }


init : String -> ( Model, Effect Msg )
init key =
    ( { requestedRoute = key
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = ReplaceMe


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        ReplaceMe ->
            ( model, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    let
        elements =
            paragraph
                [ width (maximum 400 fill)
                , height fill
                , centerX
                , centerY
                ]
                [ text ("The requested route '" ++ model.requestedRoute ++ "' does not exist!")
                ]
    in
    { title = "404"
    , body = [ elements ]
    }
