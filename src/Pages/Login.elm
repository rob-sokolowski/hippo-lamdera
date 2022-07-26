module Pages.Login exposing (Model, Msg(..), page)

import Api.Data exposing (Data(..))
import Api.User exposing (User)
import Auth.Common exposing (Flow(..))
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
    = GoogleOAuthSignInRequested
    | GotUser (Data User)


type Field
    = Email
    | Password


update : Request -> Msg -> Model -> ( Model, Effect Msg )
update req msg model =
    case msg of
        GoogleOAuthSignInRequested ->
            -- NB: 'OAuthGoogle' is a special value that will be parsed by the elm-spa route /login/:provider/callback
            Auth.Flow.signInRequested "OAuthGoogle" model Nothing
                |> Tuple.mapSecond (AuthToBackend >> sendToBackend >> Effect.fromCmd)

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
        statusString : String
        statusString =
            case model.authFlow of
                Idle ->
                    " "

                Requested methodId ->
                    "You will be redirected shortly to " ++ methodId ++ ".."

                Pending ->
                    " "

                Authorized authCode str ->
                    " "

                Authenticated token ->
                    " "

                Done userInfo ->
                    " "

                Errored err ->
                    " "
    in
    el
        [ height fill
        , width fill
        , Background.color Styling.softGrey
        ]
    <|
        column
            [ width (fill |> maximum 600)
            , height (fill |> maximum 500)
            , centerX
            , centerY
            , Background.color Styling.white
            , spacing 10
            , Border.rounded 5
            ]
            [ Input.button
                [ Border.width 1
                , Border.rounded 3
                , Border.color Styling.black
                , padding 4
                , centerY
                , centerX
                ]
                { onPress = Just GoogleOAuthSignInRequested
                , label = el [ centerX ] <| text "Sign in with Google"
                }
            , el [ centerX, centerY ] <| E.text statusString
            ]
