module Evergreen.V52.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V52.Api.Card
import Evergreen.V52.Api.User
import Evergreen.V52.Auth.Common
import Evergreen.V52.Bridge
import Evergreen.V52.Evergreen.V51.VellumClient
import Evergreen.V52.Gen.Pages
import Evergreen.V52.Shared
import Http
import Lamdera
import Random
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V52.Shared.Model
    , page : Evergreen.V52.Gen.Pages.Model
    , authFlow : Evergreen.V52.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V52.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V52.Api.Card.CardId Evergreen.V52.Api.Card.CardEnvelope
    , now : Time.Posix
    , seed : Random.Seed
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V52.Auth.Common.PendingAuth
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V52.Shared.Msg
    | Page Evergreen.V52.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V52.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V52.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V52.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | Tick Time.Posix
    | Got_VellumApiResponse Lamdera.ClientId (Result Http.Error Evergreen.V52.Evergreen.V51.VellumClient.VellumResponse)
    | Noop_BackendMsg


type ToFrontend
    = AuthToFrontend Evergreen.V52.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V52.Api.User.User
    | PageMsg Evergreen.V52.Gen.Pages.Msg
    | NoOpToFrontend
