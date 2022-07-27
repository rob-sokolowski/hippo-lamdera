module Evergreen.V28.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V28.Api.Card
import Evergreen.V28.Api.User
import Evergreen.V28.Auth.Common
import Evergreen.V28.Bridge
import Evergreen.V28.Gen.Pages
import Evergreen.V28.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V28.Shared.Model
    , page : Evergreen.V28.Gen.Pages.Model
    , authFlow : Evergreen.V28.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V28.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V28.Api.Card.CardId Evergreen.V28.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V28.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V28.Shared.Msg
    | Page Evergreen.V28.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V28.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V28.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V28.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix
    | IncrementCardId


type ToFrontend
    = AuthToFrontend Evergreen.V28.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V28.Api.User.User
    | PageMsg Evergreen.V28.Gen.Pages.Msg
    | NoOpToFrontend
