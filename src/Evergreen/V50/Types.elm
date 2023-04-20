module Evergreen.V50.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V50.Api.Card
import Evergreen.V50.Api.User
import Evergreen.V50.Auth.Common
import Evergreen.V50.Bridge
import Evergreen.V50.Gen.Pages
import Evergreen.V50.Shared
import Lamdera
import Random
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V50.Shared.Model
    , page : Evergreen.V50.Gen.Pages.Model
    , authFlow : Evergreen.V50.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V50.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V50.Api.Card.CardId Evergreen.V50.Api.Card.CardEnvelope
    , now : Time.Posix
    , seed : Random.Seed
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V50.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V50.Shared.Msg
    | Page Evergreen.V50.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V50.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V50.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V50.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | Tick Time.Posix
    | Noop_BackendMsg


type ToFrontend
    = AuthToFrontend Evergreen.V50.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V50.Api.User.User
    | PageMsg Evergreen.V50.Gen.Pages.Msg
    | NoOpToFrontend
