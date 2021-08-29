module Pages.Study exposing (Model, Msg(..), page)

import Effect exposing (Effect)
import Gen.Params.Study exposing (Params)
import Api.Card exposing (CardEnvelope, FlashCard(..))
import Api.User exposing (User)
import Api.Data exposing (..)
import Page
import Element exposing (..)
import Bridge exposing (ToBackend(..))
import Request
import Shared
import View exposing (View)
import Page
import Bridge exposing (sendToBackend)


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
    {
        cardDataFetch : Data (List CardEnvelope)
    }


init : Shared.Model -> ( Model, Effect Msg )
init shared =
    let
        fetch = case shared.user of
            Just _ ->
                Loading

            Nothing ->
                NotAsked

        model_ = {
                cardDataFetch = fetch -- fetch immediately if we have a user
            }
    in
    (model_, Effect.fromCmd <| fetchUsersStudyCards shared model_)


fetchUsersStudyCards : Shared.Model -> Model -> Cmd Msg
fetchUsersStudyCards shared _ =
    case shared.user of
        Just user ->
            sendToBackend <| FetchUsersStudyCards_Study user
        Nothing ->
            Cmd.none


-- UPDATE


type Msg
    = FetchCards User
    | GotUserCards (Data (List CardEnvelope))


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        FetchCards user ->
            ( model, Effect.none )
        
        GotUserCards cards ->

            ({model | cardDataFetch = cards}, Effect.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : User -> Model -> View Msg
view _ model =
    View.placeholder "Study"


viewCards : Data (List CardEnvelope) -> Element Msg
viewCards data =
    case data of
        NotAsked ->
            Element.none

        Loading ->
            Element.text "Loading.."

        Failure errors ->
            Element.text "Error"

        Success cards ->
            -- Element.text "success"
            let
                len = List.length cards
            in
            Element.column [] <| ( List.map viewCard cards ++ [Element.text <| "There are " ++ String.fromInt len ++ " cards"])


viewCard : CardEnvelope -> Element Msg
viewCard cardEnv =
    case cardEnv.card of
        FlashCardPlainText plainTextCard ->
            Element.column [padding 10, spacing 10] [
                Element.text plainTextCard.question
                , Element.text plainTextCard.answer
            ]
