module Pages.Home_ exposing (Model, Msg(..), Tab(..), page)

import Element as E exposing (..)
import Element.Background as Background
import Element.Font as Font
import Page
import Palette
import Request exposing (Request)
import Shared
import Utils.Task exposing (send)
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
    , fancyResult : Maybe (FancyResult FancyError FancyData)
    }


type alias FancyError =
    String


type alias FancyData =
    String


type FancyResult err data
    = FancyOk data
    | FancierOk data
    | FancyErr err


type Tab
    = Global


init : Shared.Model -> ( Model, Cmd Msg )
init shared =
    let
        model : Model
        model =
            Model Global Nothing
    in
    ( model
    , send Do_FancyThings
    )



-- UPDATE


type Msg
    = Noop
    | Do_FancyThings
    | Do_FancierThings
    | Do_Fail


type alias Tag =
    String


update : Shared.Model -> Msg -> Model -> ( Model, Cmd Msg )
update shared msg model =
    case msg of
        Do_Fail ->
            ( { model | fancyResult = Just <| FancyErr "Failed" }, Cmd.none )

        Do_FancierThings ->
            ( { model | fancyResult = Just <| FancierOk "Fancier pants" }, send Do_Fail )

        Do_FancyThings ->
            ( { model | fancyResult = Just <| FancyOk "Fancy pants" }, send Do_FancierThings )

        Noop ->
            ( model, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


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
        [ width fill

        --, height (fill |> maximum 600)
        --, height fill
        , padding 10
        , spacing 10
        , centerY
        , centerX
        , moveUp 50
        ]
        [ el
            [ Font.size 36
            , centerX
            ]
            (E.text "Hippo")
        , el
            [ width fill
            , height <| px 1
            , Background.color Palette.dimGrey
            , centerX
            ]
            (E.text " ")
        , el
            [ Font.size 14
            , centerX
            ]
            (E.paragraph [] [ E.text "Simple MarkDown flashcards with spaced-repetition study sessions" ])
        ]
