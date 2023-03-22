module Evergreen.V48.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V48.Api.Card
import Evergreen.V48.Api.User
import Evergreen.V48.Auth.Common
import Evergreen.V48.Bridge
import Evergreen.V48.Gen.Pages
import Evergreen.V48.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V48.Shared.Model
    , page : Evergreen.V48.Gen.Pages.Model
    , authFlow : Evergreen.V48.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V48.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V48.Api.Card.CardId Evergreen.V48.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V48.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V48.Shared.Msg
    | Page Evergreen.V48.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V48.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V48.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V48.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | Tick Time.Posix
    | Roll Lamdera.ClientId (List Evergreen.V48.Api.Card.CardEnvelope)
    | EVERGREEN_NOOP


type ToFrontend
    = AuthToFrontend Evergreen.V48.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V48.Api.User.User
    | PageMsg Evergreen.V48.Gen.Pages.Msg
    | NoOpToFrontend
