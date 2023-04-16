module Evergreen.V49.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V49.Api.Card
import Evergreen.V49.Api.User
import Evergreen.V49.Auth.Common
import Evergreen.V49.Bridge
import Evergreen.V49.Gen.Pages
import Evergreen.V49.Shared
import Lamdera
import Random
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V49.Shared.Model
    , page : Evergreen.V49.Gen.Pages.Model
    , authFlow : Evergreen.V49.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V49.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V49.Api.Card.CardId Evergreen.V49.Api.Card.CardEnvelope
    , now : Time.Posix
    , seed : Random.Seed
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V49.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V49.Shared.Msg
    | Page Evergreen.V49.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V49.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V49.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V49.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | Tick Time.Posix
    | Noop_BackendMsg


type ToFrontend
    = AuthToFrontend Evergreen.V49.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V49.Api.User.User
    | PageMsg Evergreen.V49.Gen.Pages.Msg
    | NoOpToFrontend
