module Pages.Login exposing (Model, Msg(..), page)

import Api.Data exposing (Data(..))
import Api.User exposing (User)
import Auth.Common
import Auth.Flow
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
import Url exposing (Url)
import Utils.Route
import View exposing (View)


page : Shared.Model -> Request -> Page.With Model Msg
page shared req =
    Page.advanced
        { init = init shared req
        , update = update req
        , subscriptions = subscriptions
        , view = view
        }



-- INIT


type alias Model =
    { email : String
    , password : String
    , authFlow : Auth.Common.Flow
    , authRedirectBaseUrl : Url
    }


init : Shared.Model -> Request -> ( Model, Effect Msg )
init shared req =
    let
        url =
            req.url
    in
    ( { email = ""
      , password = ""
      , authFlow = Auth.Common.Idle
      , authRedirectBaseUrl = { url | query = Nothing, fragment = Nothing }
      }
    , Effect.none
    )



-- UPDATE


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GoogleOAuthSignInRequested
    | GotUser (Data User)


type Field
    = Email
    | Password


update : Request -> Msg -> Model -> ( Model, Effect Msg )
update req msg model =
    case msg of
        GoogleOAuthSignInRequested ->
            Auth.Flow.signInRequested "OAuthGithub" model Nothing
                |> Tuple.mapSecond (AuthToBackend >> sendToBackend >> Effect.fromCmd)

        Updated Email email ->
            ( { model | email = email }
            , Effect.none
            )

        Updated Password password ->
            ( { model | password = password }
            , Effect.none
            )

        AttemptedSignIn ->
            ( model
            , (Effect.fromCmd << sendToBackend) <|
                UserAuthentication_Login
                    { params =
                        { email = model.email
                        , password = model.password
                        }
                    }
            )

        GotUser data ->
            case data of
                Success user ->
                    -- TODO: Should this belong in the model?
                    --( { model | user = data }
                    ( model
                    , Effect.batch
                        [ Effect.fromCmd (Utils.Route.navigate req.key Route.Home_)
                        , Effect.fromShared (Shared.SignedInUser user)
                        ]
                    )

                Failure err ->
                    ( model
                      --( { model | user = data }
                    , Effect.none
                    )

                NotAsked ->
                    ( model
                      --( { model | user = data }
                    , Effect.none
                    )

                Loading ->
                    ( model
                      --( { model | user = data }
                    , Effect.none
                    )


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- VIEW


view : Model -> View Msg
view model =
    { title = "Sign in"
    , body = [ elements model ]
    }


elements : Model -> Element Msg
elements model =
    let
        statusMessage : String
        statusMessage =
            "foo baby!"

        --case model.user of
        --    NotAsked ->
        --        ""
        --
        --    Loading ->
        --        ""
        --
        --    Failure err ->
        --        List.foldl (\e a -> e ++ a) "" err
        --
        --    Success user ->
        --        "You are signed in as " ++ user.email
    in
    column
        [ width (fill |> maximum 800)
        , height fill
        , centerX
        , Border.color Styling.black
        , spacing 10

        --, centerY
        ]
        [ text "Enter your email and password to log in."
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
            { onPress = Just AttemptedSignIn
            , label = el [ centerX ] <| text "Sign In"
            }
        , text statusMessage
        ]
