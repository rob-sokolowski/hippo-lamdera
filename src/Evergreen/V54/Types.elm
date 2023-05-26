module Evergreen.V54.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V54.Api.Card
import Evergreen.V54.Api.User
import Evergreen.V54.Auth.Common
import Evergreen.V54.Bridge
import Evergreen.V54.Gen.Pages
import Evergreen.V54.Shared
import Lamdera
import Random
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V54.Shared.Model
    , page : Evergreen.V54.Gen.Pages.Model
    , authFlow : Evergreen.V54.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V54.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V54.Api.Card.CardId Evergreen.V54.Api.Card.CardEnvelope
    , now : Time.Posix
    , seed : Random.Seed
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V54.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V54.Shared.Msg
    | Page Evergreen.V54.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V54.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V54.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V54.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | Tick Time.Posix
    | Noop_BackendMsg


type ToFrontend
    = AuthToFrontend Evergreen.V54.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V54.Api.User.User
    | PageMsg Evergreen.V54.Gen.Pages.Msg
    | NoOpToFrontend
