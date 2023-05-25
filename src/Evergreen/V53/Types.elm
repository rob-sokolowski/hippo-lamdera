module Evergreen.V53.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V53.Api.Card
import Evergreen.V53.Api.User
import Evergreen.V53.Auth.Common
import Evergreen.V53.Bridge
import Evergreen.V53.Gen.Pages
import Evergreen.V53.Shared
import Lamdera
import Random
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V53.Shared.Model
    , page : Evergreen.V53.Gen.Pages.Model
    , authFlow : Evergreen.V53.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V53.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V53.Api.Card.CardId Evergreen.V53.Api.Card.CardEnvelope
    , now : Time.Posix
    , seed : Random.Seed
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V53.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V53.Shared.Msg
    | Page Evergreen.V53.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V53.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V53.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V53.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | Tick Time.Posix
    | Noop_BackendMsg


type ToFrontend
    = AuthToFrontend Evergreen.V53.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V53.Api.User.User
    | PageMsg Evergreen.V53.Gen.Pages.Msg
    | NoOpToFrontend
