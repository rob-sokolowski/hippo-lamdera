module Frontend exposing (..)

import Audio exposing (Audio, AudioCmd)
import Auth.Common
import AuthImplementation
import Browser
import Browser.Dom
import Browser.Navigation as Nav exposing (Key)
import Effect
import Element as E exposing (..)
import Element.Border as Border
import Gen.Model
import Gen.Pages as Pages
import Gen.Route as Route
import Lamdera
import Palette
import PortDefs exposing (audioPortFromJS, audioPortToJS)
import Request
import Shared
import Task
import Types exposing (FrontendModel, FrontendModel_(..), FrontendModel_Loaded, FrontendMsg_(..), ToFrontend(..))
import Url exposing (Url)
import View


type alias Model =
    FrontendModel


app =
    Audio.lamderaFrontendWithAudio
        { init = init
        , onUrlRequest = ClickedLink
        , onUrlChange = ChangedUrl
        , update = \_ msg model -> update msg model |> (\( a, b ) -> ( a, b, Audio.cmdNone ))
        , updateFromBackend = \_ msg model -> updateFromBackend msg model |> (\( a, b ) -> ( a, b, Audio.cmdNone ))
        , subscriptions = subscriptions
        , view = view
        , audio = audio
        , audioPort = { toJS = audioPortToJS, fromJS = audioPortFromJS }
        }


audio : Audio.AudioData -> FrontendModel_ -> Audio
audio audioData model =
    case model of
        LoadingAssets _ ->
            Audio.silence

        LoadSuccess frontendLoaded ->
            -- TODO: Load audio group
            Audio.silence

        --gameAudio audioData frontendLoaded
        LoadFailure err ->
            Audio.silence



-- INIT


init : Url -> Key -> ( FrontendModel_, Cmd FrontendMsg_, AudioCmd FrontendMsg_ )
init url key =
    let
        ( shared, sharedCmd ) =
            Shared.init (Request.create () url key) ()

        ( page, effect ) =
            Pages.init (Route.fromUrl url) shared url key
    in
    ( LoadingAssets
        { url = url
        , key = key
        , shared = shared
        , page = page
        , authFlow = Auth.Common.Idle
        , authRedirectBaseUrl = url
        }
    , Cmd.batch
        [ Cmd.map Shared sharedCmd
        , Effect.toCmd ( Shared, Page ) effect
        ]
    , Audio.cmdNone
    )



-- UPDATE


scrollPageToTop =
    Task.perform (\_ -> Noop) (Browser.Dom.setViewport 0 0)


type alias Msg =
    FrontendMsg_


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ClickedLink (Browser.Internal url) ->
            ( model
            , Nav.pushUrl model.key (Url.toString url)
            )

        ClickedLink (Browser.External url) ->
            ( model
            , Nav.load url
            )

        ChangedUrl url ->
            if url.path /= model.url.path then
                let
                    ( page, effect ) =
                        Pages.init (Route.fromUrl url) model.shared url model.key
                in
                ( { model | url = url, page = page }
                , Cmd.batch [ Effect.toCmd ( Shared, Page ) effect, scrollPageToTop ]
                )

            else
                ( { model | url = url }, Cmd.none )

        Shared sharedMsg ->
            let
                ( shared, sharedCmd ) =
                    Shared.update (Request.create () model.url model.key) sharedMsg model.shared

                ( page, effect ) =
                    Pages.init (Route.fromUrl model.url) shared model.url model.key
            in
            if page == Gen.Model.Redirecting_ then
                ( { model | shared = shared, page = page }
                , Cmd.batch
                    [ Cmd.map Shared sharedCmd
                    , Effect.toCmd ( Shared, Page ) effect
                    ]
                )

            else
                ( { model | shared = shared }
                , Cmd.map Shared sharedCmd
                )

        Page pageMsg ->
            let
                ( page, effect ) =
                    Pages.update pageMsg model.page model.shared model.url model.key
            in
            ( { model | page = page }
            , Effect.toCmd ( Shared, Page ) effect
            )

        Noop ->
            ( model, Cmd.none )


updateFromBackend : ToFrontend -> Model -> ( Model, Cmd FrontendMsg_ )
updateFromBackend msg model =
    case msg of
        AuthToFrontend authToFrontendMsg ->
            AuthImplementation.updateFromBackend authToFrontendMsg model

        ActiveSession user ->
            update (Shared <| Shared.SignedInUser user) model

        PageMsg pageMsg ->
            update (Page pageMsg) model

        NoOpToFrontend ->
            ( model, Cmd.none )



-- VIEW


view : Audio.AudioData -> FrontendModel_ -> Browser.Document Msg
view _ model =
    { title = "Hippo"
    , body =
        [ layout [] (elements model) ]
    }


elements : FrontendModel_ -> Element Msg
elements model =
    let
        pageElements =
            Shared.sharedView (Request.create () model.url model.key)
                { page =
                    Pages.view model.page model.shared model.url model.key
                        |> View.map Page
                , toMsg = Shared
                }
                model.shared

        -- TODO: This feels wrong.
        firstElement =
            case List.head pageElements.body of
                Nothing ->
                    E.none

                Just e ->
                    e
    in
    E.column
        [ width (fill |> maximum 1400)
        , height fill
        , padding 3
        , centerX
        , Border.width 1
        , Border.color Palette.dimGrey
        ]
        [ firstElement ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ Pages.subscriptions model.page model.shared model.url model.key |> Sub.map Page
        , Shared.subscriptions (Request.create () model.url model.key) model.shared |> Sub.map Shared
        ]
