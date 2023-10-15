module Evergreen.V60.Types exposing (..)

import Audio
import Browser
import Browser.Navigation
import Dict
import Evergreen.V60.Api.Card
import Evergreen.V60.Api.User
import Evergreen.V60.Auth.Common
import Evergreen.V60.Bridge
import Evergreen.V60.Gen.Pages
import Evergreen.V60.Shared
import Lamdera
import Random
import Time
import Url


type FrontendMsg_
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V60.Shared.Msg
    | Page Evergreen.V60.Gen.Pages.Msg
    | Noop


type alias FrontendModel_Loading =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V60.Shared.Model
    , page : Evergreen.V60.Gen.Pages.Model
    , authFlow : Evergreen.V60.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type alias FrontendModel_Loaded =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V60.Shared.Model
    , page : Evergreen.V60.Gen.Pages.Model
    , authFlow : Evergreen.V60.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type FrontendModel_
    = LoadingAssets FrontendModel_Loading
    | LoadSuccess FrontendModel_Loaded
    | LoadFailure String


type alias FrontendModel =
    Audio.Model FrontendMsg_ FrontendModel_


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V60.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V60.Api.Card.CardId Evergreen.V60.Api.Card.CardEnvelope
    , now : Time.Posix
    , seed : Random.Seed
    , nextCardId : Int
    , pendingAuths : Dict.Dict Lamdera.SessionId Evergreen.V60.Auth.Common.PendingAuth
    , newField : Maybe Int
    }


type alias FrontendMsg =
    Audio.Msg FrontendMsg_


type alias ToBackend =
    Evergreen.V60.Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Evergreen.V60.Auth.Common.BackendMsg
    | CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V60.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | Tick Time.Posix
    | Noop_BackendMsg


type ToFrontend
    = AuthToFrontend Evergreen.V60.Auth.Common.ToFrontend
    | ActiveSession Evergreen.V60.Api.User.User
    | PageMsg Evergreen.V60.Gen.Pages.Msg
    | NoOpToFrontend
