module Evergreen.V19.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V19.Api.Card
import Evergreen.V19.Api.User
import Evergreen.V19.Bridge
import Evergreen.V19.Gen.Pages
import Evergreen.V19.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V19.Shared.Model
    , page : Evergreen.V19.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V19.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V19.Api.Card.CardId Evergreen.V19.Api.Card.CardEnvelope
    , now : Time.Posix
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V19.Shared.Msg
    | Page Evergreen.V19.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V19.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V19.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = ActiveSession Evergreen.V19.Api.User.User
    | PageMsg Evergreen.V19.Gen.Pages.Msg
    | NoOpToFrontend
