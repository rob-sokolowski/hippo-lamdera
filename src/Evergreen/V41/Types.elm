module Evergreen.V41.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V41.Api.Card
import Evergreen.V41.Api.User
import Evergreen.V41.Auth.Common
import Evergreen.V41.Bridge
import Evergreen.V41.Gen.Pages
import Evergreen.V41.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V41.Shared.Model
    , page : Evergreen.V41.Gen.Pages.Model
    , authFlow : Evergreen.V41.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V41.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V41.Api.Card.CardId Evergreen.V41.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V41.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V41.Shared.Msg
    | Page Evergreen.V41.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V41.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V41.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V41.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = AuthToFrontend Evergreen.V41.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V41.Api.User.User
    | PageMsg Evergreen.V41.Gen.Pages.Msg
    | NoOpToFrontend
