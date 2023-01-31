module Pages.Stories.MathJaxDemo exposing (Model, Msg, page)

import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Font as Font
import Gen.Params.Stories.MathJaxDemo exposing (Params)
import Html exposing (Html)
import Html.Attributes as HA
import Json.Encode
import Page
import Pages.Stories.Data as Data
import Pages.Stories.Expression as Expression
import Pages.Stories.KaTeX exposing (DisplayMode(..), mathText)
import Palette
import Request
import Scripta.API
import Scripta.Language exposing (Language(..))
import Shared
import Utils.Task exposing (send)
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.advanced
        { init = init
        , update = update
        , view = view
        , subscriptions = subscriptions
        }



-- INIT


type alias Model =
    { sourceText : String
    }


init : ( Model, Effect Msg )
init =
    ( { sourceText = Data.initialText
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = Noop


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        Noop ->
            ( model, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Story | MathJax"
    , body =
        [ el
            [ width fill
            , height fill
            ]
            (E.html (viewHtml model))
        ]
    }


viewHtml : Model -> Html Msg
viewHtml model =
    Html.p []
        [ Expression.compile model.sourceText ]
