module Evergreen.V33.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V33.Api.Card
import Evergreen.V33.Api.User
import Evergreen.V33.Auth.Common
import Evergreen.V33.Bridge
import Evergreen.V33.Gen.Pages
import Evergreen.V33.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V33.Shared.Model
    , page : Evergreen.V33.Gen.Pages.Model
    , authFlow : Evergreen.V33.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V33.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V33.Api.Card.CardId Evergreen.V33.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V33.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V33.Shared.Msg
    | Page Evergreen.V33.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V33.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V33.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V33.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = AuthToFrontend Evergreen.V33.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V33.Api.User.User
    | PageMsg Evergreen.V33.Gen.Pages.Msg
    | NoOpToFrontend
