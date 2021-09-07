module Pages.Catalog exposing (Model, Msg(..), page)

import Api.Card exposing (CardEnvelope, CardId, FlashCard(..), Grade(..), MarkdownCard, PlainTextCard, StudySessionSummary)
import Api.Data exposing (Data(..))
import Api.User exposing (User)
import Bridge exposing (ToBackend(..))
import Components.Styling as S exposing (..)
import Dev.ComponentDemoData exposing (catalogTableDemoData)
import Effect exposing (Effect)
import Element exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Gen.Params.Catalog exposing (Params)
import Lamdera exposing (sendToBackend)
import Page
import Request
import Shared
import Time exposing (toHour, toMinute, toSecond, utc)
import Time.Extra
import View exposing (View)


page : Shared.Model -> Request.With Params -> Page.With Model Msg
page shared req =
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
    { user : Maybe User
    , zone : Time.Zone
    , wiredCards : Data (List CardEnvelope)
    , selectedEnv : Maybe CardEnvelope
    }


init : Shared.Model -> ( Model, Effect Msg )
init shared =
    let
        wiredCatalogInit =
            case shared.user of
                Just _ ->
                    Loading

                Nothing ->
                    NotAsked

        eff =
            case wiredCatalogInit of
                Loading ->
                    Effect.fromCmd <| fetchUsersCatalog shared.user

                _ ->
                    Effect.none

        model =
            { user = shared.user
            , wiredCards = wiredCatalogInit
            , zone = shared.zone
            , selectedEnv = Nothing
            }
    in
    ( model
    , eff
    )



-- UPDATE


type Msg
    = FetchUserCatalog User
    | GotUserCatalog (Data (List CardEnvelope))
    | UserSelectedCard CardEnvelope
    | UserMousesOver CardEnvelope


update : Msg -> Model -> ( Model, Effect Msg )
update msg model =
    case msg of
        GotUserCatalog catalog ->
            ( { model | wiredCards = catalog }, Effect.none )

        FetchUserCatalog user ->
            ( { model
                | wiredCards = Loading
              }
            , Effect.fromCmd <| fetchUsersCatalog (Just user)
            )

        UserSelectedCard cardEnv ->
            ( { model | selectedEnv = Just cardEnv }, Effect.none )

        UserMousesOver cardEnv ->
            ( model, Effect.none )


fetchUsersCatalog : Maybe User -> Cmd Msg
fetchUsersCatalog user =
    case user of
        Just u ->
            sendToBackend <| FetchUsersCatalog_Catalog u

        Nothing ->
            Cmd.none



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- VIEW


view : User -> Model -> View Msg
view _ model =
    { title = "Your Card Catalog"
    , body =
        [ layout [] <| viewElements model
        ]
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

                viewHoverArea cardEnv =
                    case cardEnv of
                        _ ->
                            el
                                [ onClick (UserSelectedCard cardEnv)
                                ]
                            <|
                                Element.text "hover"
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
                    , { header = el headerAttrs <| Element.text "hover"
                      , width = fillPortion 1
                      , view = \cardEnv -> viewHoverArea cardEnv
                      }
                    ]
                }

        elements =
            case model.wiredCards of
                NotAsked ->
                    Element.text "Catalog not asked for"

                Loading ->
                    Element.text "Catalog is laoding"

                Success catalog ->
                    viewCatalogTable catalog

                Failure errs ->
                    Element.column [] <| List.map (\e -> Element.text e) errs
    in
    elements



-- Helper funcs


posixToTime : Time.Zone -> Time.Posix -> String
posixToTime zone posix =
    (String.padLeft 2 '0' <| String.fromInt <| Time.toHour zone posix)
        ++ ":"
        ++ (String.padLeft 2 '0' <| String.fromInt <| Time.toMinute zone posix)
        ++ ":"
        ++ (String.padLeft 2 '0' <| String.fromInt <| Time.toSecond zone posix)
