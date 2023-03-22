module Evergreen.V43.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V43.Api.Card
import Evergreen.V43.Api.User
import Evergreen.V43.Auth.Common
import Evergreen.V43.Bridge
import Evergreen.V43.Gen.Pages
import Evergreen.V43.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V43.Shared.Model
    , page : Evergreen.V43.Gen.Pages.Model
    , authFlow : Evergreen.V43.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V43.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V43.Api.Card.CardId Evergreen.V43.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V43.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V43.Shared.Msg
    | Page Evergreen.V43.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V43.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V43.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V43.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = AuthToFrontend Evergreen.V43.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V43.Api.User.User
    | PageMsg Evergreen.V43.Gen.Pages.Msg
    | NoOpToFrontend
