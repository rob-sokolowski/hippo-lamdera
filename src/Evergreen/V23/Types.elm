module Evergreen.V23.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V23.Api.Card
import Evergreen.V23.Api.User
import Evergreen.V23.Bridge
import Evergreen.V23.Gen.Pages
import Evergreen.V23.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V23.Shared.Model
    , page : Evergreen.V23.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V23.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V23.Api.Card.CardId Evergreen.V23.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V23.Shared.Msg
    | Page Evergreen.V23.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V23.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V23.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix
    | IncrementCardId


type ToFrontend
    = ActiveSession Evergreen.V23.Api.User.User
    | PageMsg Evergreen.V23.Gen.Pages.Msg
    | NoOpToFrontend
