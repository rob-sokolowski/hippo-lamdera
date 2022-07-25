module Pages.Register exposing (Model, Msg(..), page)

import Api.Data exposing (Data(..))
import Api.User exposing (User)
import Bridge exposing (..)
import Components.Styling as Styling
import Effect exposing (Effect)
import Element as E exposing (..)
import Element.Border as Border
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
    , email : String
    , password : String
    , passwordConfirmed : String
    , formState : FormState
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
        Incomplete
    , Effect.none
    )



-- UPDATE


type Msg
    = Updated Field String
    | AttemptedSignUp
    | GotUser (Data User)


type Field
    = Email
    | Password
    | PasswordConfirmation


update : Request -> Msg -> Model -> ( Model, Effect Msg )
update req msg model =
    let
        computeFormState : String -> String -> String -> FormState
        computeFormState email_ password_ pwdConfirm =
            if email_ == "" || password_ == "" then
                Incomplete

            else if password_ /= "" && (password_ /= pwdConfirm) then
                PasswordMismatch

            else if password_ /= "" && (password_ == pwdConfirm) then
                Complete

            else
                Incomplete
    in
    case msg of
        Updated Email email ->
            ( { model
                | email = email
                , formState = computeFormState email model.password model.passwordConfirmed
              }
            , Effect.none
            )

        Updated Password password ->
            ( { model
                | password = password
                , formState = computeFormState model.email password model.passwordConfirmed
              }
            , Effect.none
            )

        Updated PasswordConfirmation confirm ->
            ( { model
                | passwordConfirmed = confirm
                , formState = computeFormState model.email model.password confirm
              }
            , Effect.none
            )

        AttemptedSignUp ->
            ( model
            , (Effect.fromCmd << sendToBackend) <|
                UserRegistration_Register
                    { params =
                        { username = "" -- TODO: I'm isolating this front-end change to avoid backend evergreen stuff, some cleanup required
                        , email = model.email
                        , password = model.password
                        }
                    }
            )

        GotUser data ->
            case data of
                Success user ->
                    ( { model | user = data }
                    , Effect.batch
                        [ Effect.fromCmd (Utils.Route.navigate req.key Route.Home_)
                        , Effect.fromShared (Shared.SignedInUser user)
                        ]
                    )

                Failure err ->
                    ( { model | user = data }
                    , Effect.none
                    )

                NotAsked ->
                    ( { model | user = data }
                    , Effect.none
                    )

                Loading ->
                    ( { model | user = data }
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


type FormState
    = Incomplete
    | PasswordMismatch
    | Complete


elements : Model -> Element Msg
elements model =
    let
        statusText : String
        statusText =
            case model.formState of
                Incomplete ->
                    "Please enter an email and password"

                PasswordMismatch ->
                    "Password do not match!"

                Complete ->
                    " "

        buttonAttrs : List (Attribute Msg)
        buttonAttrs =
            let
                color =
                    case model.formState of
                        Complete ->
                            Styling.black

                        _ ->
                            Styling.softGrey
            in
            [ Border.color color
            , Font.color color
            ]

        buttonCmd =
            case model.formState of
                Complete ->
                    Just AttemptedSignUp

                _ ->
                    Nothing

        responseStatusText : String
        responseStatusText =
            case model.user of
                NotAsked ->
                    ""

                Loading ->
                    ""

                Failure err ->
                    List.foldl (\e a -> e ++ a) "" err

                Success user ->
                    "You are signed in as " ++ user.email
    in
    column
        [ width (fill |> maximum 800)
        , height fill
        , centerX
        , padding 5
        , spacing 7

        --, centerY
        ]
        [ el [ Font.size 14 ] <| text "No tracking of any kind is implemented, and you will never be emailed by this app."
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
        , Input.currentPassword
            []
            { onChange = Updated PasswordConfirmation
            , text = model.passwordConfirmed
            , placeholder = Nothing
            , show = False
            , label = Input.labelLeft [] <| text "Confirm Password:"
            }
        , row
            [ width fill ]
            [ el [ alignLeft ] <| text statusText
            , Input.button
                ([ alignRight
                 , Border.width 1
                 , Border.rounded 3
                 , padding 4
                 , alignRight
                 ]
                    ++ buttonAttrs
                )
                { onPress = buttonCmd
                , label = el [ centerX ] <| text "Sign Up"
                }
            ]
        , el [] <| text responseStatusText
        ]
