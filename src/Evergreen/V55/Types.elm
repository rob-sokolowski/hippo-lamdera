module Evergreen.V55.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V55.Api.Card
import Evergreen.V55.Api.User
import Evergreen.V55.Auth.Common
import Evergreen.V55.Bridge
import Evergreen.V55.Gen.Pages
import Evergreen.V55.Shared
import Lamdera
import Random
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V55.Shared.Model
    , page : Evergreen.V55.Gen.Pages.Model
    , authFlow : Evergreen.V55.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V55.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V55.Api.Card.CardId Evergreen.V55.Api.Card.CardEnvelope
    , now : Time.Posix
    , seed : Random.Seed
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V55.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V55.Shared.Msg
    | Page Evergreen.V55.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V55.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V55.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V55.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | Tick Time.Posix
    | Noop_BackendMsg


type ToFrontend
    = AuthToFrontend Evergreen.V55.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V55.Api.User.User
    | PageMsg Evergreen.V55.Gen.Pages.Msg
    | NoOpToFrontend
