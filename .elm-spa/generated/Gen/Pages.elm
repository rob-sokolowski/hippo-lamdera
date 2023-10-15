module Gen.Pages exposing (Model, Msg, init, subscriptions, update, view)

import Browser.Navigation exposing (Key)
import Effect exposing (Effect)
import ElmSpa.Page
import Gen.Params.Admin
import Gen.Params.Cards
import Gen.Params.Catalog
import Gen.Params.Home_
import Gen.Params.Login
import Gen.Params.NotFound
import Gen.Params.Study
import Gen.Params.Login.Provider_.Callback
import Gen.Params.Stories.ElmAudio
import Gen.Params.Stories.KatexDemo
import Gen.Params.Stories.VellumTesting
import Gen.Model as Model
import Gen.Msg as Msg
import Gen.Route as Route exposing (Route)
import Page exposing (Page)
import Pages.Admin
import Pages.Cards
import Pages.Catalog
import Pages.Home_
import Pages.Login
import Pages.NotFound
import Pages.Study
import Pages.Login.Provider_.Callback
import Pages.Stories.ElmAudio
import Pages.Stories.KatexDemo
import Pages.Stories.VellumTesting
import Request exposing (Request)
import Shared
import Task
import Url exposing (Url)
import View exposing (View)


type alias Model =
    Model.Model


type alias Msg =
    Msg.Msg


init : Route -> Shared.Model -> Url -> Key -> ( Model, Effect Msg )
init route =
    case route of
        Route.Admin ->
            pages.admin.init ()
    
        Route.Cards ->
            pages.cards.init ()
    
        Route.Catalog ->
            pages.catalog.init ()
    
        Route.Home_ ->
            pages.home_.init ()
    
        Route.Login ->
            pages.login.init ()
    
        Route.NotFound ->
            pages.notFound.init ()
    
        Route.Study ->
            pages.study.init ()
    
        Route.Login__Provider___Callback params ->
            pages.login__provider___callback.init params
    
        Route.Stories__ElmAudio ->
            pages.stories__elmAudio.init ()
    
        Route.Stories__KatexDemo ->
            pages.stories__katexDemo.init ()
    
        Route.Stories__VellumTesting ->
            pages.stories__vellumTesting.init ()


update : Msg -> Model -> Shared.Model -> Url -> Key -> ( Model, Effect Msg )
update msg_ model_ =
    case ( msg_, model_ ) of
        ( Msg.Admin msg, Model.Admin params model ) ->
            pages.admin.update params msg model
    
        ( Msg.Cards msg, Model.Cards params model ) ->
            pages.cards.update params msg model
    
        ( Msg.Catalog msg, Model.Catalog params model ) ->
            pages.catalog.update params msg model
    
        ( Msg.Home_ msg, Model.Home_ params model ) ->
            pages.home_.update params msg model
    
        ( Msg.Login msg, Model.Login params model ) ->
            pages.login.update params msg model
    
        ( Msg.NotFound msg, Model.NotFound params model ) ->
            pages.notFound.update params msg model
    
        ( Msg.Study msg, Model.Study params model ) ->
            pages.study.update params msg model
    
        ( Msg.Login__Provider___Callback msg, Model.Login__Provider___Callback params model ) ->
            pages.login__provider___callback.update params msg model
    
        ( Msg.Stories__ElmAudio msg, Model.Stories__ElmAudio params model ) ->
            pages.stories__elmAudio.update params msg model
    
        ( Msg.Stories__KatexDemo msg, Model.Stories__KatexDemo params model ) ->
            pages.stories__katexDemo.update params msg model
    
        ( Msg.Stories__VellumTesting msg, Model.Stories__VellumTesting params model ) ->
            pages.stories__vellumTesting.update params msg model

        _ ->
            \_ _ _ -> ( model_, Effect.none )


view : Model -> Shared.Model -> Url -> Key -> View Msg
view model_ =
    case model_ of
        Model.Redirecting_ ->
            \_ _ _ -> View.none
    
        Model.Admin params model ->
            pages.admin.view params model
    
        Model.Cards params model ->
            pages.cards.view params model
    
        Model.Catalog params model ->
            pages.catalog.view params model
    
        Model.Home_ params model ->
            pages.home_.view params model
    
        Model.Login params model ->
            pages.login.view params model
    
        Model.NotFound params model ->
            pages.notFound.view params model
    
        Model.Study params model ->
            pages.study.view params model
    
        Model.Login__Provider___Callback params model ->
            pages.login__provider___callback.view params model
    
        Model.Stories__ElmAudio params model ->
            pages.stories__elmAudio.view params model
    
        Model.Stories__KatexDemo params model ->
            pages.stories__katexDemo.view params model
    
        Model.Stories__VellumTesting params model ->
            pages.stories__vellumTesting.view params model


subscriptions : Model -> Shared.Model -> Url -> Key -> Sub Msg
subscriptions model_ =
    case model_ of
        Model.Redirecting_ ->
            \_ _ _ -> Sub.none
    
        Model.Admin params model ->
            pages.admin.subscriptions params model
    
        Model.Cards params model ->
            pages.cards.subscriptions params model
    
        Model.Catalog params model ->
            pages.catalog.subscriptions params model
    
        Model.Home_ params model ->
            pages.home_.subscriptions params model
    
        Model.Login params model ->
            pages.login.subscriptions params model
    
        Model.NotFound params model ->
            pages.notFound.subscriptions params model
    
        Model.Study params model ->
            pages.study.subscriptions params model
    
        Model.Login__Provider___Callback params model ->
            pages.login__provider___callback.subscriptions params model
    
        Model.Stories__ElmAudio params model ->
            pages.stories__elmAudio.subscriptions params model
    
        Model.Stories__KatexDemo params model ->
            pages.stories__katexDemo.subscriptions params model
    
        Model.Stories__VellumTesting params model ->
            pages.stories__vellumTesting.subscriptions params model



-- INTERNALS


pages :
    { admin : Bundle Gen.Params.Admin.Params Pages.Admin.Model Pages.Admin.Msg
    , cards : Bundle Gen.Params.Cards.Params Pages.Cards.Model Pages.Cards.Msg
    , catalog : Bundle Gen.Params.Catalog.Params Pages.Catalog.Model Pages.Catalog.Msg
    , home_ : Bundle Gen.Params.Home_.Params Pages.Home_.Model Pages.Home_.Msg
    , login : Bundle Gen.Params.Login.Params Pages.Login.Model Pages.Login.Msg
    , notFound : Bundle Gen.Params.NotFound.Params Pages.NotFound.Model Pages.NotFound.Msg
    , study : Bundle Gen.Params.Study.Params Pages.Study.Model Pages.Study.Msg
    , login__provider___callback : Bundle Gen.Params.Login.Provider_.Callback.Params Pages.Login.Provider_.Callback.Model Pages.Login.Provider_.Callback.Msg
    , stories__elmAudio : Bundle Gen.Params.Stories.ElmAudio.Params Pages.Stories.ElmAudio.Model Pages.Stories.ElmAudio.Msg
    , stories__katexDemo : Bundle Gen.Params.Stories.KatexDemo.Params Pages.Stories.KatexDemo.Model Pages.Stories.KatexDemo.Msg
    , stories__vellumTesting : Bundle Gen.Params.Stories.VellumTesting.Params Pages.Stories.VellumTesting.Model Pages.Stories.VellumTesting.Msg
    }
pages =
    { admin = bundle Pages.Admin.page Model.Admin Msg.Admin
    , cards = bundle Pages.Cards.page Model.Cards Msg.Cards
    , catalog = bundle Pages.Catalog.page Model.Catalog Msg.Catalog
    , home_ = bundle Pages.Home_.page Model.Home_ Msg.Home_
    , login = bundle Pages.Login.page Model.Login Msg.Login
    , notFound = bundle Pages.NotFound.page Model.NotFound Msg.NotFound
    , study = bundle Pages.Study.page Model.Study Msg.Study
    , login__provider___callback = bundle Pages.Login.Provider_.Callback.page Model.Login__Provider___Callback Msg.Login__Provider___Callback
    , stories__elmAudio = bundle Pages.Stories.ElmAudio.page Model.Stories__ElmAudio Msg.Stories__ElmAudio
    , stories__katexDemo = bundle Pages.Stories.KatexDemo.page Model.Stories__KatexDemo Msg.Stories__KatexDemo
    , stories__vellumTesting = bundle Pages.Stories.VellumTesting.page Model.Stories__VellumTesting Msg.Stories__VellumTesting
    }


type alias Bundle params model msg =
    ElmSpa.Page.Bundle params model msg Shared.Model (Effect Msg) Model Msg (View Msg)


bundle page toModel toMsg =
    ElmSpa.Page.bundle
        { redirecting =
            { model = Model.Redirecting_
            , view = View.none
            }
        , toRoute = Route.fromUrl
        , toUrl = Route.toHref
        , fromCmd = Effect.fromCmd
        , mapEffect = Effect.map toMsg
        , mapView = View.map toMsg
        , toModel = toModel
        , toMsg = toMsg
        , page = page
        }


type alias Static params =
    Bundle params () Never


static : View Never -> (params -> Model) -> Static params
static view_ toModel =
    { init = \params _ _ _ -> ( toModel params, Effect.none )
    , update = \params _ _ _ _ _ -> ( toModel params, Effect.none )
    , view = \_ _ _ _ _ -> View.map never view_
    , subscriptions = \_ _ _ _ _ -> Sub.none
    }
    
