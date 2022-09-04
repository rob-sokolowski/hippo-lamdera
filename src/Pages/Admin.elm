module Pages.Admin exposing (Model, Msg(..), page)

import Api.Admin exposing (AdminSummary)
import Api.User exposing (User)
import Bridge exposing (ToBackend(..))
import Effect exposing (Effect)
import Element as E exposing (Element)
import Gen.Params.Admin exposing (Params)
import Lamdera
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
    { adminSummary : Maybe (List AdminSummary)
    }


init : User -> ( Model, Effect Msg )
init user =
    ( { adminSummary = Nothing
      }
    , Effect.fromCmd <| (FetchAdminSummary user |> Lamdera.sendToBackend)
    )



-- UPDATE


type Msg
    = GotAdminSummary (List AdminSummary)


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        GotAdminSummary adminSummary ->
            ( { model | adminSummary = Just adminSummary }, Effect.none )



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
    let
        toSummary : AdminSummary -> String
        toSummary sum =
            String.fromInt sum.userId ++ "-" ++ String.fromInt sum.cardId ++ " : " ++ sum.question ++ " : " ++ sum.answer

        viewAdminSummary : Element Msg
        viewAdminSummary =
            case model.adminSummary of
                Nothing ->
                    E.none

                Just summaries ->
                    E.column [] (List.map (\sum -> E.text <| toSummary sum) summaries)
    in
    case user.email of
        "rpsoko@gmail.com" ->
            E.column []
                [ E.text "Welcome, Admin"
                , viewAdminSummary
                ]

        _ ->
            E.text "You are not authorized to view this page"
