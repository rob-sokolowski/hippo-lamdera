module Evergreen.V40.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V40.Api.Card
import Evergreen.V40.Api.User
import Evergreen.V40.Auth.Common
import Evergreen.V40.Bridge
import Evergreen.V40.Gen.Pages
import Evergreen.V40.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V40.Shared.Model
    , page : Evergreen.V40.Gen.Pages.Model
    , authFlow : Evergreen.V40.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V40.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V40.Api.Card.CardId Evergreen.V40.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V40.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V40.Shared.Msg
    | Page Evergreen.V40.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V40.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V40.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V40.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = AuthToFrontend Evergreen.V40.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V40.Api.User.User
    | PageMsg Evergreen.V40.Gen.Pages.Msg
    | NoOpToFrontend
