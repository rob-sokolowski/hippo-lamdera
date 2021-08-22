module Pages.Study exposing (Model, Msg, page)

import Effect exposing (Effect)
import Gen.Params.Study exposing (Params)
import Api.User exposing (User)
import Page
import Request
import Shared
import View exposing (View)
import Page


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared _ =
    Page.protected.advanced
        (\user ->
            { init = init shared
            , update = update
            , subscriptions = subscriptions
            , view = view user
            }
        )

-- INIT


type alias Model =
    {}


init : Shared.Model -> ( Model, Effect Msg )
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
view _ model =
    View.placeholder "Study"
