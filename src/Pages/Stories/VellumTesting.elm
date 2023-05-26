module Pages.Stories.VellumTesting exposing (Model, Msg(..), page)

import Bridge exposing (ToBackend(..), sendToBackend)
import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events as Events
import Element.Font as Font
import Element.Input as Input
import Gen.Params.Stories.KatexDemo exposing (Params)
import Http
import Page
import Pages.Login exposing (rotationLoop, spinner)
import Palette
import Request
import Shared
import Utils exposing (animatedEl)
import VellumClient exposing (PingResponse, RemoteData(..), VellumInputValues, VellumResponse, extractFlashcardText, fetchSummaryFlashCards, pingServer)
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


type alias Model =
    { nCards : Int
    , title : String
    , author : String
    , response : RemoteData Http.Error VellumResponse
    , vellumText : Maybe String
    , pingResponse : RemoteData Http.Error PingResponse
    }


init : Shared.Model -> ( Model, Effect Msg )
init shared =
    ( { nCards = 4
      , title = ""
      , author = ""
      , response = NotAsked
      , vellumText = Nothing
      , pingResponse = NotAsked
      }
    , Effect.none
    )



-- UPDATE


type FormField
    = NumCards
    | Title
    | Author


type Msg
    = UpdatedFormField FormField String
    | UpdatedSlider Float
    | UserPressedVellumAssist
    | UserPressedPing
    | Got_PingResponse (Result Http.Error PingResponse)
    | Got_VellumResponse (Result Http.Error VellumResponse)


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        UserPressedPing ->
            ( { model | pingResponse = Loading }, Effect.fromCmd <| pingServer 10000 Got_PingResponse )

        Got_PingResponse result ->
            case result of
                Ok pingResponse ->
                    ( { model | pingResponse = Success pingResponse }, Effect.none )

                Err error ->
                    ( { model | pingResponse = Failure error }, Effect.none )

        Got_VellumResponse result ->
            case result of
                Ok vellumResponse ->
                    ( { model | response = Success vellumResponse }, Effect.none )

                Err error ->
                    ( { model | response = Failure error }, Effect.none )

        UserPressedVellumAssist ->
            let
                vals : VellumInputValues
                vals =
                    { nCards = model.nCards
                    , title = model.title
                    , author = model.author
                    }
            in
            ( { model | response = Loading }
            , Effect.fromCmd (fetchSummaryFlashCards vals Got_VellumResponse)
              --, Effect.fromCmd (sendToBackend <| Proxy_VellumApi vals)
            )

        UpdatedFormField field val ->
            case field of
                Title ->
                    ( { model | title = val }, Effect.none )

                Author ->
                    ( { model | author = val }, Effect.none )

                NumCards ->
                    -- Note: This path is unreachable since slider vals are floats, refer to UpdatedSlider Msg
                    ( model, Effect.none )

        UpdatedSlider val ->
            ( { model | nCards = round val }, Effect.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Vellum Testing"
    , body =
        [ el
            [ width fill
            , height fill
            , Background.color Palette.lightGrey
            ]
            (viewElements model)
        ]
    }


viewNumCardsSlider : Model -> Element Msg
viewNumCardsSlider model =
    Input.slider
        [ height (px 25)
        , behindContent <|
            -- Slider track
            el
                [ width fill
                , height <| px 5
                , centerY
                , Background.color Palette.grey
                , Border.rounded 6
                ]
                E.none
        ]
        { onChange = UpdatedSlider
        , label =
            Input.labelAbove [ Font.size 14 ] <|
                text "Number of cards to generate"
        , min = 1.0
        , max = 10.0
        , value = toFloat model.nCards
        , thumb =
            Input.thumb
                [ width <| px 20
                , height <| px 20
                , Border.width 2
                , Border.rounded 6
                , Border.color Palette.darkCharcoal
                , Background.color Palette.white
                ]
        , step = Just 1.0
        }


viewElements : Model -> Element Msg
viewElements model =
    E.column
        [ width
            (fill
                |> maximum 800
                |> minimum 200
            )
        , height fill
        , Background.color Palette.white
        , centerX
        , padding 10
        , spacing 10
        ]
        [ E.text "Vellum testing"
        , row [ height (px 50), width fill ]
            [ el [ height fill, width (px 200) ] (viewNumCardsSlider model)
            , el [ centerY, height fill ] <| text (String.fromInt model.nCards)
            ]
        , Input.text []
            { onChange = UpdatedFormField Title
            , text = model.title
            , placeholder = Nothing
            , label = Input.labelAbove [ Font.size 14 ] <| text "Title:"
            }
        , Input.text []
            { onChange = UpdatedFormField Author
            , text = model.author
            , placeholder = Nothing
            , label = Input.labelAbove [ Font.size 14 ] <| text "Author:"
            }
        , Input.button
            [ width shrink
            , paddingXY 10 0
            , height (px 30)
            , Background.color Palette.lightGrey
            , Border.rounded 5
            , Border.color Palette.darkCharcoal
            , Border.width 1
            , Font.size 12
            ]
            { onPress = Just UserPressedVellumAssist
            , label = text "Vellum Assist (beta)"
            }
        , viewResponsePanel model model.response
        , Input.button
            [ width shrink
            , paddingXY 10 0
            , height (px 30)
            , Background.color Palette.lightGrey
            , Border.rounded 5
            , Border.color Palette.darkCharcoal
            , Border.width 1
            , Font.size 12
            ]
            { onPress = Just UserPressedPing
            , label = text "Ping proxy"
            }
        ]


viewResponsePanel : Model -> RemoteData Http.Error VellumResponse -> Element Msg
viewResponsePanel model response =
    let
        el_ =
            case response of
                NotAsked ->
                    text "Fill form above, click assist"

                Loading ->
                    row [ width fill ]
                        [ text "Getting help from Vellum..."
                        , animatedEl rotationLoop [] spinner
                        ]

                Success vellumResponse ->
                    column []
                        (paragraph [ Font.bold ] [ text "Vellum response:" ]
                            :: List.map (\vt -> paragraph [] [ text vt ]) (extractFlashcardText vellumResponse)
                        )

                Failure error ->
                    case error of
                        Http.BadUrl string ->
                            text <| "Bad URL: " ++ string

                        Http.Timeout ->
                            text "Timeout"

                        Http.NetworkError ->
                            text "Network error"

                        Http.BadStatus int ->
                            text <| "Bad status: " ++ String.fromInt int

                        Http.BadBody string ->
                            text <| "Bad body: " ++ string
    in
    el [ height shrink ] el_
