module Pages.Home_ exposing (Model, Msg(..), page)

import Api.Data exposing (Data)
import Api.User exposing (User)
import Bridge exposing (..)
import Components.Styling as Styling
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
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


type Tab
    = Global


init : Shared.Model -> ( Model, Cmd Msg )
init shared =
    let
        model : Model
        model =
            Model Global
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
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW
--view : Shared.Model -> Model -> View Msg
--view shared model =
--    { title = ""
--    , body =
--        [ div [ class "home-page" ]
--            [ div [ class "banner" ]
--                [ div [ class "container" ]
--                    [ h1 [ class "logo-font" ] [ text "hippo" ]
--                    , p [] [ text "flash cards" ]
--                    ]
--                ]
--            ]
--        ]
--    }


view : Shared.Model -> Model -> View Msg
view shared model =
    { title = "Homepage"
    , body =
        [ elements model
        ]
    }


elements : Model -> Element msg
elements model =
    column
        [ width (fill |> maximum 800)

        --, height (fill |> maximum 600)
        , height fill
        , padding 10
        , spacing 10
        , centerY
        , centerX
        , Border.width 2
        , Border.rounded 5
        , Border.color Styling.black
        ]
        [ el
            [ Font.size 36
            , centerX
            ]
            (E.text "Hippo")
        , el
            [ width fill
            , height <| px 1
            , Background.color Styling.dimGrey
            , centerX
            ]
            (E.text " ")
        , el
            [ Font.size 14
            , centerX
            ]
            (E.text "Simple MarkDown flashcards with spaced-repetition study sessions")
        ]
