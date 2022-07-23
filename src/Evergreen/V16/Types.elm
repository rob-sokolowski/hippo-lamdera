module Evergreen.V16.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V16.Api.Card
import Evergreen.V16.Api.User
import Evergreen.V16.Bridge
import Evergreen.V16.Gen.Pages
import Evergreen.V16.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V16.Shared.Model
    , page : Evergreen.V16.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V16.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V16.Api.Card.CardId Evergreen.V16.Api.Card.CardEnvelope
    , now : Time.Posix
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V16.Shared.Msg
    | Page Evergreen.V16.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V16.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V16.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = ActiveSession Evergreen.V16.Api.User.User
    | PageMsg Evergreen.V16.Gen.Pages.Msg
    | NoOpToFrontend
