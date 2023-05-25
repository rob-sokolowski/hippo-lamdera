module Types exposing (..)

import Api.Card exposing (CardEnvelope, CardId, FlashCard)
import Api.User exposing (User, UserFull, UserId)
import Auth.Common
import Bridge
import Browser
import Browser.Navigation exposing (Key)
import Dict exposing (Dict)
import Evergreen.V51.VellumClient exposing (VellumResponse)
import Gen.Pages as Pages
import Http
import Lamdera exposing (ClientId, SessionId)
import Random exposing (Seed)
import Shared
import Time
import Url exposing (Url)


type alias FrontendModel =
    { url : Url
    , key : Key
    , shared : Shared.Model
    , page : Pages.Model
    , authFlow : Auth.Common.Flow
    , authRedirectBaseUrl : Url
    }


type alias Session =
    { userId : Int, expires : Time.Posix }


type FrontendMsg
    = ChangedUrl Url
    | ClickedLink Browser.UrlRequest
    | Shared Shared.Msg
    | Page Pages.Msg
    | Noop


type alias BackendModel =
    { sessions : Dict SessionId Session
    , users : Dict Int UserFull
    , cards : Dict CardId CardEnvelope
    , now : Time.Posix
    , seed : Seed
    , nextCardId : Int
    , pendingAuths : Dict SessionId Auth.Common.PendingAuth
    }


type alias ToBackend =
    Bridge.ToBackend


type BackendMsg
    = AuthBackendMsg Auth.Common.BackendMsg
    | CheckSession SessionId ClientId
    | RenewSession UserId SessionId ClientId Time.Posix
    | Tick Time.Posix
    | Got_VellumApiResponse ClientId (Result Http.Error VellumResponse)
    | Noop_BackendMsg


type ToFrontend
    = AuthToFrontend Auth.Common.ToFrontend
    | ActiveSession User
    | PageMsg Pages.Msg
    | NoOpToFrontend
