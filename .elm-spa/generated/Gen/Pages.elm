module Gen.Pages exposing (Model, Msg, init, subscriptions, update, view)

import Browser.Navigation exposing (Key)
import Effect exposing (Effect)
import ElmSpa.Page
import Gen.Params.Cards
import Gen.Params.Catalog
import Gen.Params.Home_
import Gen.Params.Login
import Gen.Params.NotFound
import Gen.Params.Register
import Gen.Params.Study
import Gen.Model as Model
import Gen.Msg as Msg
import Gen.Route as Route exposing (Route)
import Page exposing (Page)
import Pages.Cards
import Pages.Catalog
import Pages.Home_
import Pages.Login
import Pages.NotFound
import Pages.Register
import Pages.Study
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
    
        Route.Register ->
            pages.register.init ()
    
        Route.Study ->
            pages.study.init ()


update : Msg -> Model -> Shared.Model -> Url -> Key -> ( Model, Effect Msg )
update msg_ model_ =
    case ( msg_, model_ ) of
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
    
        ( Msg.Register msg, Model.Register params model ) ->
            pages.register.update params msg model
    
        ( Msg.Study msg, Model.Study params model ) ->
            pages.study.update params msg model

        _ ->
            \_ _ _ -> ( model_, Effect.none )


view : Model -> Shared.Model -> Url -> Key -> View Msg
view model_ =
    case model_ of
        Model.Redirecting_ ->
            \_ _ _ -> View.none
    
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
    
        Model.Register params model ->
            pages.register.view params model
    
        Model.Study params model ->
            pages.study.view params model


subscriptions : Model -> Shared.Model -> Url -> Key -> Sub Msg
subscriptions model_ =
    case model_ of
        Model.Redirecting_ ->
            \_ _ _ -> Sub.none
    
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
    
        Model.Register params model ->
            pages.register.subscriptions params model
    
        Model.Study params model ->
            pages.study.subscriptions params model



-- INTERNALS


pages :
    { cards : Bundle Gen.Params.Cards.Params Pages.Cards.Model Pages.Cards.Msg
    , catalog : Bundle Gen.Params.Catalog.Params Pages.Catalog.Model Pages.Catalog.Msg
    , home_ : Bundle Gen.Params.Home_.Params Pages.Home_.Model Pages.Home_.Msg
    , login : Bundle Gen.Params.Login.Params Pages.Login.Model Pages.Login.Msg
    , notFound : Bundle Gen.Params.NotFound.Params Pages.NotFound.Model Pages.NotFound.Msg
    , register : Bundle Gen.Params.Register.Params Pages.Register.Model Pages.Register.Msg
    , study : Bundle Gen.Params.Study.Params Pages.Study.Model Pages.Study.Msg
    }
pages =
    { cards = bundle Pages.Cards.page Model.Cards Msg.Cards
    , catalog = bundle Pages.Catalog.page Model.Catalog Msg.Catalog
    , home_ = bundle Pages.Home_.page Model.Home_ Msg.Home_
    , login = bundle Pages.Login.page Model.Login Msg.Login
    , notFound = bundle Pages.NotFound.page Model.NotFound Msg.NotFound
    , register = bundle Pages.Register.page Model.Register Msg.Register
    , study = bundle Pages.Study.page Model.Study Msg.Study
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
    
