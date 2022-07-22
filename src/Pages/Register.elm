module Pages.Register exposing (Model, Msg(..), page)

import Api.Data exposing (Data)
import Api.User exposing (User)
import Bridge exposing (..)
import Components.Styling as Styling
import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Gen.Route as Route
import Page
import Request exposing (Request)
import Shared
import Utils.Route
import View exposing (View)


page : Shared.Model -> Request -> Page.With Model Msg
page shared req =
    Page.advanced
        { init = init shared
        , update = update req
        , subscriptions = subscriptions
        , view = view
        }



-- INIT


type alias Model =
    { user : Data User
    , displayName : String
    , email : String
    , password : String
    }


init : Shared.Model -> ( Model, Effect Msg )
init shared =
    ( Model
        (case shared.user of
            Just user ->
                Api.Data.Success user

            Nothing ->
                Api.Data.NotAsked
        )
        ""
        ""
        ""
    , Effect.none
    )



-- UPDATE


type Msg
    = Updated Field String
    | AttemptedSignUp
    | GotUser (Data User)


type Field
    = Username
    | Email
    | Password


update : Request -> Msg -> Model -> ( Model, Effect Msg )
update req msg model =
    case msg of
        Updated Username username ->
            ( { model | displayName = username }
            , Effect.none
            )

        Updated Email email ->
            ( { model | email = email }
            , Effect.none
            )

        Updated Password password ->
            ( { model | password = password }
            , Effect.none
            )

        AttemptedSignUp ->
            ( model
            , (Effect.fromCmd << sendToBackend) <|
                UserRegistration_Register
                    { params =
                        { username = model.displayName
                        , email = model.email
                        , password = model.password
                        }
                    }
            )

        GotUser user ->
            case Api.Data.toMaybe user of
                Just user_ ->
                    ( { model | user = user }
                    , Effect.batch
                        [ Effect.fromCmd (Utils.Route.navigate req.key Route.Home_)
                        , Effect.fromShared (Shared.SignedInUser user_)
                        ]
                    )

                Nothing ->
                    ( { model | user = user }
                    , Effect.none
                    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Sign up"
    , body = [ elements model ]
    }


elements : Model -> Element Msg
elements model =
    column
        [ width (fill |> maximum 800)
        , height fill
        , centerX
        , padding 5
        , spacing 5

        --, centerY
        ]
        [ Input.text []
            { onChange = Updated Username
            , text = model.displayName
            , placeholder = Nothing
            , label = Input.labelLeft [] <| text "Display name:"
            }
        , Input.username []
            { onChange = Updated Email
            , text = model.email
            , placeholder = Nothing
            , label = Input.labelLeft [] <| text "Email:"
            }
        , Input.currentPassword []
            { onChange = Updated Password
            , text = model.password
            , placeholder = Nothing
            , show = False
            , label = Input.labelLeft [] <| text "Password:"
            }
        , Input.button
            [ alignRight
            , Border.width 1
            , Border.rounded 3
            , Border.color Styling.black
            , padding 4
            ]
            { onPress = Just AttemptedSignUp
            , label = el [ centerX ] <| text "sign up"
            }
        ]
