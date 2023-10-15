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
    ( LoadSuccess
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


update : FrontendMsg_ -> FrontendModel_ -> ( FrontendModel_, Cmd FrontendMsg_ )
update msg model =
    case model of
        LoadingAssets model_ ->
            updateLoading msg model_

        LoadSuccess model_ ->
            updateLoaded msg model_

        LoadFailure err ->
            ( model, Cmd.none )


updateLoaded : FrontendMsg_ -> FrontendModel_Loaded -> ( FrontendModel_, Cmd FrontendMsg_ )
updateLoaded msg model =
    case msg of
        ClickedLink (Browser.Internal url) ->
            ( LoadSuccess model
            , Nav.pushUrl model.key (Url.toString url)
            )

        ClickedLink (Browser.External url) ->
            ( LoadSuccess model
            , Nav.load url
            )

        ChangedUrl url ->
            if url.path /= model.url.path then
                let
                    ( page, effect ) =
                        Pages.init (Route.fromUrl url) model.shared url model.key
                in
                ( LoadSuccess { model | url = url, page = page }
                , Cmd.batch [ Effect.toCmd ( Shared, Page ) effect, scrollPageToTop ]
                )

            else
                ( LoadSuccess { model | url = url }, Cmd.none )

        Shared sharedMsg ->
            let
                ( shared, sharedCmd ) =
                    Shared.update (Request.create () model.url model.key) sharedMsg model.shared

                ( page, effect ) =
                    Pages.init (Route.fromUrl model.url) shared model.url model.key
            in
            if page == Gen.Model.Redirecting_ then
                ( LoadSuccess { model | shared = shared, page = page }
                , Cmd.batch
                    [ Cmd.map Shared sharedCmd
                    , Effect.toCmd ( Shared, Page ) effect
                    ]
                )

            else
                ( LoadSuccess { model | shared = shared }
                , Cmd.map Shared sharedCmd
                )

        Page pageMsg ->
            let
                ( page, effect ) =
                    Pages.update pageMsg model.page model.shared model.url model.key
            in
            ( LoadSuccess { model | page = page }
            , Effect.toCmd ( Shared, Page ) effect
            )

        Noop ->
            ( LoadSuccess model, Cmd.none )


updateLoading : FrontendMsg_ -> FrontendModel_Loaded -> ( FrontendModel_, Cmd FrontendMsg_ )
updateLoading msg model =
    case msg of
        ClickedLink (Browser.Internal url) ->
            ( LoadingAssets model
            , Nav.pushUrl model.key (Url.toString url)
            )

        ClickedLink (Browser.External url) ->
            ( LoadingAssets model
            , Nav.load url
            )

        ChangedUrl url ->
            if url.path /= model.url.path then
                let
                    ( page, effect ) =
                        Pages.init (Route.fromUrl url) model.shared url model.key
                in
                ( LoadingAssets { model | url = url, page = page }
                , Cmd.batch [ Effect.toCmd ( Shared, Page ) effect, scrollPageToTop ]
                )

            else
                ( LoadingAssets { model | url = url }, Cmd.none )

        Shared sharedMsg ->
            let
                ( shared, sharedCmd ) =
                    Shared.update (Request.create () model.url model.key) sharedMsg model.shared

                ( page, effect ) =
                    Pages.init (Route.fromUrl model.url) shared model.url model.key
            in
            if page == Gen.Model.Redirecting_ then
                ( LoadingAssets { model | shared = shared, page = page }
                , Cmd.batch
                    [ Cmd.map Shared sharedCmd
                    , Effect.toCmd ( Shared, Page ) effect
                    ]
                )

            else
                ( LoadingAssets { model | shared = shared }
                , Cmd.map Shared sharedCmd
                )

        Page pageMsg ->
            let
                ( page, effect ) =
                    Pages.update pageMsg model.page model.shared model.url model.key
            in
            ( LoadingAssets { model | page = page }
            , Effect.toCmd ( Shared, Page ) effect
            )

        Noop ->
            ( LoadingAssets model, Cmd.none )


updateFromBackend : ToFrontend -> FrontendModel_ -> ( FrontendModel_, Cmd FrontendMsg_ )
updateFromBackend msg model =
    case msg of
        AuthToFrontend authToFrontendMsg ->
            case model of
                LoadingAssets frontendModel_Loading ->
                    ( model, Cmd.none )

                LoadSuccess frontendModel_Loaded ->
                    let
                        ( model_, cmd ) =
                            AuthImplementation.updateFromBackend authToFrontendMsg frontendModel_Loaded
                    in
                    ( LoadSuccess model_, cmd )

                LoadFailure string ->
                    ( model, Cmd.none )

        -- TODO: Do I need to thread-through all of the FrontendModel_ stuff into Auth??
        ActiveSession user ->
            update (Shared <| Shared.SignedInUser user) model

        PageMsg pageMsg ->
            update (Page pageMsg) model

        NoOpToFrontend ->
            ( model, Cmd.none )



-- VIEW


view : Audio.AudioData -> FrontendModel_ -> Browser.Document Msg
view _ model =
    let
        layout_ =
            layout []
    in
    { title = "Hippo"
    , body = [ layout [] (elements model) ]

    --case model of
    --    LoadingAssets model_ ->
    --        [ layout_ <| elements () ]
    --
    --    LoadSuccess model_ ->
    --        [ layout_ <| elements (LoadSuccess model_) ]
    --
    --    LoadFailure er ->
    --        [ layout_ <| text "Failed to load audio assets!" ]
    }


elements : FrontendModel_ -> Element Msg
elements model =
    let
        elements_ =
            case model of
                LoadingAssets model_ ->
                    E.text "Loading..."

                LoadFailure err ->
                    text <| "Load failure: " ++ err

                LoadSuccess model_ ->
                    let
                        pageElements =
                            Shared.sharedView (Request.create () model_.url model_.key)
                                { page =
                                    Pages.view model_.page model_.shared model_.url model_.key
                                        |> View.map Page
                                , toMsg = Shared
                                }
                                model_.shared

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
    in
    elements_



-- SUBSCRIPTIONS


subscriptions : Audio.AudioData -> FrontendModel_ -> Sub FrontendMsg_
subscriptions _ model =
    case model of
        -- TODO: clean up dupe logic
        LoadingAssets model_ ->
            Sub.batch
                [ Pages.subscriptions model_.page model_.shared model_.url model_.key |> Sub.map Page
                , Shared.subscriptions (Request.create () model_.url model_.key) model_.shared |> Sub.map Shared
                ]

        LoadSuccess model_ ->
            Sub.batch
                [ Pages.subscriptions model_.page model_.shared model_.url model_.key |> Sub.map Page
                , Shared.subscriptions (Request.create () model_.url model_.key) model_.shared |> Sub.map Shared
                ]

        LoadFailure err ->
            Sub.none
