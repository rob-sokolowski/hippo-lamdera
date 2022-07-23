module Evergreen.V17.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V17.Api.Card
import Evergreen.V17.Api.User
import Evergreen.V17.Bridge
import Evergreen.V17.Gen.Pages
import Evergreen.V17.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V17.Shared.Model
    , page : Evergreen.V17.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V17.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V17.Api.Card.CardId Evergreen.V17.Api.Card.CardEnvelope
    , now : Time.Posix
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V17.Shared.Msg
    | Page Evergreen.V17.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V17.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V17.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = ActiveSession Evergreen.V17.Api.User.User
    | PageMsg Evergreen.V17.Gen.Pages.Msg
    | NoOpToFrontend
