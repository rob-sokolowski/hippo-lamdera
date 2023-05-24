module Evergreen.V51.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V51.Api.Card
import Evergreen.V51.Api.User
import Evergreen.V51.Auth.Common
import Evergreen.V51.Bridge
import Evergreen.V51.Gen.Pages
import Evergreen.V51.Shared
import Lamdera
import Random
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V51.Shared.Model
    , page : Evergreen.V51.Gen.Pages.Model
    , authFlow : Evergreen.V51.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V51.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V51.Api.Card.CardId Evergreen.V51.Api.Card.CardEnvelope
    , now : Time.Posix
    , seed : Random.Seed
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V51.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V51.Shared.Msg
    | Page Evergreen.V51.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V51.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V51.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V51.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | Tick Time.Posix
    | Noop_BackendMsg


type ToFrontend
    = AuthToFrontend Evergreen.V51.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V51.Api.User.User
    | PageMsg Evergreen.V51.Gen.Pages.Msg
    | NoOpToFrontend
