module Pages.Study exposing (Model, Msg(..), page)

import Effect exposing (Effect)
import Gen.Params.Study exposing (Params)
import Api.Card exposing (CardEnvelope, FlashCard(..))
import Api.User exposing (User)
import Api.Data exposing (..)
import Page
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Bridge exposing (ToBackend(..))
import Request
import Shared
import List exposing (..)
import View exposing (View)
import Page
import Bridge exposing (sendToBackend)
import Dict
import Api.Card exposing (PlainTextCard)


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
        -- TODO: Prompt state needs to be a variant type once other flashcard variants are implemented!
        --       I'm not sure where that should live, so punting on that decision atm.
        , promptStatus : PromptStatus
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
                , promptStatus = Idle
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

            ({model | cardDataFetch = cards, promptStatus = QuestionPrompted}, Effect.none)



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : User -> Model -> View Msg
view _ model =
    { title = "Title string for cards"
    , body = [layout [] <| viewElements model]
    }


viewElements : Model -> Element Msg
viewElements model =
    Element.column [centerX] [
        viewPrompt model
    ]


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


viewPlainTextFlashcardPrompt : PlainTextCard -> PromptStatus -> Element Msg
viewPlainTextFlashcardPrompt card ps =
    let
        elements = case ps of
            Idle ->
                Element.none
            QuestionPrompted ->
                 Element.column [
                    Border.width 2
                    , Border.color colors.darkCharcoal
                    , padding 10
                    , spacing 20
                ] [
                    Element.text card.question
                    , Element.row [spacing 10] [
                        Input.button
                            [ Background.color colors.darkCharcoal
                            , Font.color colors.lightBlue
                            , Border.color colors.lightGrey
                            , paddingXY 32 16
                            , Border.rounded 3
                            , Element.width fill
                            ]
                            {
                                onPress = Nothing
                                , label = Element.text "Save the whales!"
                            }
                        , Input.button
                            [ Background.color colors.darkCharcoal
                            , Font.color colors.lightBlue
                            , Border.color colors.lightGrey
                            , paddingXY 32 16
                            , Border.rounded 3
                            , Element.width fill
                            ]
                            {
                                onPress = Nothing
                                , label = Element.text "Shave the whales!"
                            }
                    ]
                ]
            Graded ->
                Element.text "Graded"
    in
    elements
   


viewPrompt : Model -> Element Msg
viewPrompt model =
    let
        elements = case model.cardDataFetch of
            NotAsked ->
                Element.text "Not asked."
            Loading ->
                Element.text "Loading.."
            Failure errs ->
                Element.column [] <| List.map (\e -> Element.text e) errs
            Success cards ->
                let
                    card = List.head cards
                    els = case card of
                        Just env ->
                            case env.card of
                                FlashCardPlainText plainTextCard ->
                                    viewPlainTextFlashcardPrompt plainTextCard model.promptStatus
                        Nothing ->
                            Element.text "You have studied all your cards!"
                in
                
                Element.column [] [
                    els
                ]
            
    in
    
    Element.column [padding 10, spacing 10 ] [elements]


type PromptStatus
    = Idle
    | QuestionPrompted
    | Graded

colors =
    { blue = rgb255 0x72 0x9F 0xCF
    , darkCharcoal = rgb255 0x2E 0x34 0x36
    , lightBlue = rgb255 0xC5 0xE8 0xF7
    , lightGrey = rgb255 0xE0 0xE0 0xE0
    , white = rgb255 0xFF 0xFF 0xFF
    }    