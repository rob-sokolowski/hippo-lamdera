module Evergreen.V42.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V42.Api.Card
import Evergreen.V42.Api.User
import Evergreen.V42.Auth.Common
import Evergreen.V42.Bridge
import Evergreen.V42.Gen.Pages
import Evergreen.V42.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V42.Shared.Model
    , page : Evergreen.V42.Gen.Pages.Model
    , authFlow : Evergreen.V42.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V42.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V42.Api.Card.CardId Evergreen.V42.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V42.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V42.Shared.Msg
    | Page Evergreen.V42.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V42.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V42.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V42.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = AuthToFrontend Evergreen.V42.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V42.Api.User.User
    | PageMsg Evergreen.V42.Gen.Pages.Msg
    | NoOpToFrontend
