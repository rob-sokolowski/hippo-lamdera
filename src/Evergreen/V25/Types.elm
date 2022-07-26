module Evergreen.V25.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V25.Api.Card
import Evergreen.V25.Api.User
import Evergreen.V25.Auth.Common
import Evergreen.V25.Bridge
import Evergreen.V25.Gen.Pages
import Evergreen.V25.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V25.Shared.Model
    , page : Evergreen.V25.Gen.Pages.Model
    , authFlow : Evergreen.V25.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V25.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V25.Api.Card.CardId Evergreen.V25.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V25.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V25.Shared.Msg
    | Page Evergreen.V25.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V25.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V25.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V25.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix
    | IncrementCardId


type ToFrontend
    = AuthToFrontend Evergreen.V25.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V25.Api.User.User
    | PageMsg Evergreen.V25.Gen.Pages.Msg
    | NoOpToFrontend
