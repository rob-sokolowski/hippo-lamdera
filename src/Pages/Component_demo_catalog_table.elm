module Pages.Component_demo_catalog_table exposing (Model, Msg, page)

import Animator
import Api.Card exposing (CardEnvelope, FlashCard(..), PromptFrequency(..))
import Color
import Components.Styling as S
import Dev.ComponentDemoData exposing (catalogTableDemoData)
import Dict exposing (Dict)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Gen.Params.Component_demo_catalog_table exposing (Params)
import Page
import Request
import Shared
import Time
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
    { zone : Time.Zone
    , catalog : List CardEnvelope
    , selectedEnv : Maybe CardEnvelope
    , buttonStates : Animator.Timeline (Dict Id State)
    }


type Msg
    = AnimatorTick Time.Posix
    | UserHoveredButton Id
    | UserUnhoveredButton Id


type alias Id =
    String


type State
    = Default
    | Hover


init : Shared.Model -> ( Model, Effect Msg )
init shared =
    ( { zone = shared.zone
      , catalog = catalogTableDemoData
      , selectedEnv = Nothing
      , buttonStates =
            Animator.init <|
                Dict.fromList [ ( "Uno", Default ), ( "Dos", Default ), ( "Tres", Default ) ]
      }
    , Effect.none
    )


data =
    catalogTableDemoData



-- UPDATE


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    let
        maybeAlways value =
            Maybe.map (\_ -> value)

        setButtonState id newState =
            Dict.update id (maybeAlways newState) <| Animator.current model.buttonStates
    in
    case msg of
        AnimatorTick newTime ->
            ( Animator.update newTime animator model
            , Effect.none
            )

        UserHoveredButton id ->
            ( { model
                | buttonStates =
                    Animator.go Animator.quickly (setButtonState id Hover) model.buttonStates
              }
            , Effect.none
            )

        UserUnhoveredButton id ->
            ( { model
                | buttonStates =
                    Animator.go Animator.quickly (setButtonState id Default) model.buttonStates
              }
            , Effect.none
            )



-- SUBSCRIPTIONS


animator : Animator.Animator Model
animator =
    Animator.animator
        |> Animator.watchingWith
            .buttonStates
            (\newButtonStates model ->
                { model | buttonStates = newButtonStates }
            )
            (\buttonStates ->
                List.any ((==) Hover) <| Dict.values buttonStates
            )


subscriptions : Model -> Sub Msg
subscriptions model =
    Animator.toSubscription AnimatorTick model animator



-- VIEW


view : Model -> View Msg
view model =
    { title = "Component Demo: Catalog Table"
    , body = [ viewElements model ]
    }


viewElements : Model -> Element Msg
viewElements model =
    let
        viewCatalogTable : List CardEnvelope -> Element Msg
        viewCatalogTable cardEnvs =
            let
                headerAttrs =
                    [ Font.bold
                    , Font.color S.black
                    , Border.widthEach { bottom = 1, top = 0, left = 0, right = 0 }
                    , Border.color S.dimGrey
                    , Border.width 1
                    ]

                viewType card =
                    case card of
                        Markdown mkCard ->
                            Element.text "Markdown card"

                        PlainText ptCard ->
                            Element.text "plain text card"
            in
            table
                [ width shrink
                , spacing 10
                , padding 20
                ]
                { data = cardEnvs
                , columns =
                    [ { header = el headerAttrs <| Element.text "card_id"
                      , width = fillPortion 2
                      , view = .id >> String.fromInt >> Element.text >> el [ centerY ]
                      }
                    , { header = el headerAttrs <| Element.text "card_type"
                      , width = fillPortion 1
                      , view = \cardEnv -> viewType cardEnv.card
                      }
                    , { header = el headerAttrs <| Element.text "user_id"
                      , width = fillPortion 1
                      , view = .userId >> String.fromInt >> Element.text >> el [ centerY ]
                      }
                    , { header = el headerAttrs <| Element.text "next_prompt"
                      , width = fillPortion 1
                      , view = .nextPromptSchedFor >> posixToTime model.zone >> Element.text >> el [ centerY ]
                      }
                    ]
                }
    in
    Element.column []
        [ viewCatalogTable catalogTableDemoData
        , buttons model
        ]


buttons : Model -> Element Msg
buttons model =
    let
        buttonState id =
            Maybe.withDefault Default <| Dict.get id <| Animator.current model.buttonStates

        borderColor id =
            fromRgb <|
                Color.toRgba <|
                    if buttonState id == Hover then
                        Color.blue

                    else
                        Color.black

        bgColor id =
            fromRgb <|
                Color.toRgba <|
                    Animator.color model.buttonStates <|
                        \buttonStates ->
                            if (Maybe.withDefault Default <| Dict.get id buttonStates) == Hover then
                                Color.lightBlue

                            else
                                Color.white

        button id =
            el
                [ width <| px 200
                , height <| px 60
                , Border.width 3
                , Border.rounded 6
                , Border.color <| borderColor id
                , Background.color <| bgColor id
                , padding 10
                , onMouseEnter <| UserHoveredButton id
                , onMouseLeave <| UserUnhoveredButton id
                ]
            <|
                (el [ centerX, centerY ] <| text <| "Button " ++ id)
    in
    [ "Uno", "Dos", "Tres" ]
        |> List.map button
        |> column [ spacing 10, centerX, centerY ]



-- utility funcs


posixToTime : Time.Zone -> Time.Posix -> String
posixToTime zone posix =
    (String.padLeft 2 '0' <| String.fromInt <| Time.toHour zone posix)
        ++ ":"
        ++ (String.padLeft 2 '0' <| String.fromInt <| Time.toMinute zone posix)
        ++ ":"
        ++ (String.padLeft 2 '0' <| String.fromInt <| Time.toSecond zone posix)
