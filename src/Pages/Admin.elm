module Pages.Admin exposing (Model, Msg, page)

import Api.User exposing (User)
import Effect exposing (Effect)
import Element as E exposing (Element)
import Gen.Params.Admin exposing (Params)
import Page
import Request
import Shared
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.protected.advanced
        (\user ->
            { init = init user
            , update = update
            , subscriptions = subscriptions
            , view = view user
            }
        )



-- INIT


type alias Model =
    {}


init : User -> ( Model, Effect Msg )
init _ =
    ( {}, Effect.none )



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


view : User -> Model -> View Msg
view user model =
    { title = "New Card Editor"
    , body = [ viewElements model user ]
    }


viewElements : Model -> User -> Element Msg
viewElements model user =
    case user.email of
        "rpsoko@gmail.com" ->
            E.text "Welcome, Admin."

        _ ->
            E.text "You are not authorized to view this page"


viewAdminPanel model