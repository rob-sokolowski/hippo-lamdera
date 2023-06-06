module Evergreen.V56.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V56.Api.Card
import Evergreen.V56.Api.User
import Evergreen.V56.Auth.Common
import Evergreen.V56.Bridge
import Evergreen.V56.Gen.Pages
import Evergreen.V56.Shared
import Lamdera
import Random
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V56.Shared.Model
    , page : Evergreen.V56.Gen.Pages.Model
    , authFlow : Evergreen.V56.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V56.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V56.Api.Card.CardId Evergreen.V56.Api.Card.CardEnvelope
    , now : Time.Posix
    , seed : Random.Seed
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V56.Auth.Common.PendingAuth
    , newField : Maybe Int
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V56.Shared.Msg
    | Page Evergreen.V56.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V56.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V56.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V56.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | Tick Time.Posix
    | Noop_BackendMsg


type ToFrontend
    = AuthToFrontend Evergreen.V56.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V56.Api.User.User
    | PageMsg Evergreen.V56.Gen.Pages.Msg
    | NoOpToFrontend
