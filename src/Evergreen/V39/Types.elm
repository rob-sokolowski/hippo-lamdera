module Evergreen.V39.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V39.Api.Card
import Evergreen.V39.Api.User
import Evergreen.V39.Auth.Common
import Evergreen.V39.Bridge
import Evergreen.V39.Gen.Pages
import Evergreen.V39.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V39.Shared.Model
    , page : Evergreen.V39.Gen.Pages.Model
    , authFlow : Evergreen.V39.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V39.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V39.Api.Card.CardId Evergreen.V39.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V39.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V39.Shared.Msg
    | Page Evergreen.V39.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V39.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V39.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V39.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = AuthToFrontend Evergreen.V39.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V39.Api.User.User
    | PageMsg Evergreen.V39.Gen.Pages.Msg
    | NoOpToFrontend
