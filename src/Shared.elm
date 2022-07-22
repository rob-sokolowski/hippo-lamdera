module Shared exposing
    ( Flags
    , Model
    , Msg(..)
    , init
    , sharedView
    , subscriptions
    , update
    )

import Api.User exposing (User)
import Bridge exposing (..)
import Components.Footer
import Components.Navbar
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Html exposing (..)
import Html.Attributes exposing (class, href, rel)
import Request exposing (Request)
import Task
import Time
import Utils.Route
import View exposing (View)



-- INIT


type alias Flags =
    ()


type alias Model =
    { user : Maybe User
    , zone : Time.Zone
    }


init : Request -> Flags -> ( Model, Cmd Msg )
init _ json =
    ( Model Nothing Time.utc
    , Task.perform SetTimeZoneToLocale Time.here
    )



-- UPDATE


type Msg
    = ClickedSignOut
    | SignedInUser User
    | SetTimeZoneToLocale Time.Zone


update : Request -> Msg -> Model -> ( Model, Cmd Msg )
update _ msg model =
    case msg of
        SignedInUser user ->
            ( { model | user = Just user }
            , Cmd.none
            )

        ClickedSignOut ->
            ( { model | user = Nothing }
            , model.user |> Maybe.map (\user -> sendToBackend (SignedOut user)) |> Maybe.withDefault Cmd.none
            )

        SetTimeZoneToLocale newZone ->
            ( { model | zone = newZone }, Cmd.none )


subscriptions : Request -> Model -> Sub Msg
subscriptions _ _ =
    Sub.none



-- VIEW


sharedView :
    Request
    -> { page : View msg, toMsg : Msg -> msg }
    -> Model
    -> View msg
sharedView req { page, toMsg } model =
    { title =
        if String.isEmpty page.title then
            "Hippo"

        else
            page.title ++ " | Hippo"
    , body =
        [ elements req { page = page, toMsg = toMsg } model
        ]
    }


elements : Request -> { page : View msg, toMsg : Msg -> msg } -> Model -> Element msg
elements req { page, toMsg } model =
    let
        navBar : Element msg
        navBar =
            Components.Navbar.view
                { user = model.user
                , currentRoute = Utils.Route.fromUrl req.url
                , onSignOut = toMsg ClickedSignOut
                }
    in
    column
        [ width fill
        , height fill
        , centerX
        ]
        [ navBar
        , column
            [ width fill
            , height fill
            ]
            page.body
        ]
