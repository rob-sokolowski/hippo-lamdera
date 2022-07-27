module Pages.Login exposing (Model, Msg(..), page)

import Api.Data exposing (Data(..))
import Api.User exposing (User)
import Auth.Common exposing (Flow(..))
import Auth.Flow
import Bridge exposing (..)
import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Gen.Route as Route
import Page
import Palette
import Request exposing (Request)
import Shared
import Simple.Animation as Animation exposing (Animation)
import Simple.Animation.Property as P
import Url exposing (Url)
import Utils exposing (animatedEl)
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
    | GitHubOAuthSignInRequested
    | GotUser (Data User)


type Field
    = Email
    | Password


update : Request -> Msg -> Model -> ( Model, Effect Msg )
update req msg model =
    case msg of
        GoogleOAuthSignInRequested ->
            -- NB: 'OAuthGoogle' is a special String value that will be parsed by the elm-spa route /login/:provider/callback
            Auth.Flow.signInRequested "OAuthGoogle" model Nothing
                |> Tuple.mapSecond (AuthToBackend >> sendToBackend >> Effect.fromCmd)

        GitHubOAuthSignInRequested ->
            -- NB: 'OAuthGithub' is a special String value that will be parsed by the elm-spa route /login/:provider/callback
            Auth.Flow.signInRequested "OAuthGithub" model Nothing
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
        statusBar : Element Msg
        statusBar =
            let
                text =
                    case model.authFlow of
                        Idle ->
                            ""

                        Requested methodId ->
                            "Redirecting to " ++ methodId ++ ".."

                        Pending ->
                            ""

                        Authorized authCode str ->
                            ""

                        Authenticated token ->
                            ""

                        Done userInfo ->
                            ""

                        Errored err ->
                            ""

                spinnerContainer : Element Msg
                spinnerContainer =
                    case model.authFlow of
                        Requested _ ->
                            animatedEl rotationLoop [] spinner

                        _ ->
                            none
            in
            row
                [ centerX
                ]
                [ paragraph [ centerX, centerY, Font.size 14 ] [ E.text text ]
                , spinnerContainer
                ]
    in
    el
        [ height fill
        , width fill
        , Background.color Palette.softGrey
        ]
    <|
        column
            [ width (fill |> maximum 600)
            , height (fill |> maximum 400)
            , centerX
            , centerY
            , Background.color Palette.white
            , spacing 10
            , Border.rounded 5
            ]
            [ paragraph [ padding 5 ] [ text "Please select an auth provider below" ]
            , paragraph [ padding 5, Font.size 12 ] [ text "No tracking of any kind is implemented, and you will never be emailed by this app." ]
            , E.text " "
            , E.text " "
            , Input.button
                [ Border.width 1
                , Border.rounded 3
                , Border.color Palette.black
                , padding 4

                --, centerY
                , centerX
                ]
                { onPress = Just GoogleOAuthSignInRequested
                , label = el [ centerX ] <| text "Sign in with Google"
                }
            , Input.button
                [ Border.width 1
                , Border.rounded 3
                , Border.color Palette.black
                , padding 4

                --, centerY
                , centerX
                ]
                { onPress = Just GitHubOAuthSignInRequested
                , label = el [ centerX ] <| text "Sign in with GitHub"
                }
            , statusBar
            ]


rotationLoop : Animation
rotationLoop =
    Animation.steps
        { startAt = [ P.rotate 0 ]
        , options = [ Animation.loop ]
        }
        [ Animation.step 1000 [ P.rotate 360 ]
        ]


spinner : Element msg
spinner =
    E.el
        [ E.width (E.px 30)
        , E.height (E.px 30)
        , Background.color Palette.white
        , Border.rounded 25
        , Border.color Palette.blue
        , Border.width 3
        ]
        (E.el
            [ E.width (E.px 10)
            , E.height (E.px 10)
            , Background.color Palette.blue
            , Border.rounded 10
            , Border.color Palette.blue
            , Border.width 3
            , E.moveUp 5
            ]
            E.none
        )
