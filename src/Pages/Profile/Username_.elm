module Pages.Profile.Username_ exposing (Model, Msg(..), page)

import Api.Data exposing (Data)
import Api.Profile exposing (Profile)
import Api.User exposing (User)
import Bridge exposing (..)
import Components.IconButton as IconButton
import Components.NotFound
import Gen.Params.Profile.Username_ exposing (Params)
import Html exposing (..)
import Html.Attributes exposing (class, classList, src)
import Html.Events as Events
import Page
import Request
import Shared
import Utils.Maybe
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
    Page.element
        { init = init shared req
        , update = update shared
        , subscriptions = subscriptions
        , view = view shared
        }



-- INIT


type alias Model =
    { username : String
    , profile : Data Profile
    , selectedTab : Tab
    , page : Int
    }


type Tab
    = MyArticles
    | FavoritedArticles


init : Shared.Model -> Request.With Params -> ( Model, Cmd Msg )
init shared { params } =
    ( { username = params.username
      , profile = Api.Data.Loading
      , selectedTab = MyArticles
      , page = 1
      }
    , Cmd.batch
        [ ProfileGet_Profile__Username_
            { username = params.username
            }
            |> sendToBackend
        ]
    )









-- UPDATE


type Msg
    = GotProfile (Data Profile)



update : Shared.Model -> Msg -> Model -> ( Model, Cmd Msg )
update shared msg model =
    case msg of
        GotProfile profile ->
            ( { model | profile = profile }
            , Cmd.none
            )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Shared.Model -> Model -> View Msg
view shared model =
    { title = "Profile"
    , body =
        case model.profile of
            Api.Data.Success profile ->
                [ viewProfile shared profile model ]

            Api.Data.Failure _ ->
                [ Components.NotFound.view ]

            _ ->
                []
    }


viewProfile : Shared.Model -> Profile -> Model -> Html Msg
viewProfile shared profile model =
    div [ class "profile-page" ]
        [ 
        -- cool
        ]
