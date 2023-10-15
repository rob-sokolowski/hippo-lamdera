module Pages.Stories.ElmAudio exposing (Model, Msg, page)

import Audio
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
import Shared
import Time
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


type SoundState
    = NotPlaying
    | Playing Time.Posix
    | FadingOut Time.Posix Time.Posix


type LoadState
    = NotAsked
    | Loading
    | LoadedSuccess AudioData
    | LoadFailed


type alias AudioData =
    { sound : Audio.Source
    , soundState : SoundState
    }


type alias Model =
    { loadState : LoadState
    }


init : Shared.Model -> ( Model, Effect Msg )
init shared =
    ( { loadState = Loading }
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
    { title = "Stories - Elm Audio"
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
    el [ width fill, height fill ] (viewControlPanel model)


viewControlPanel : Model -> Element Msg
viewControlPanel model =
    el [ centerX, centerY ] (text "Control Panel")
