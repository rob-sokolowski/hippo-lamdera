module Evergreen.V5.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V5.Api.Card
import Evergreen.V5.Api.User
import Evergreen.V5.Bridge
import Evergreen.V5.Gen.Pages
import Evergreen.V5.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V5.Shared.Model
    , page : Evergreen.V5.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V5.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V5.Api.Card.CardId Evergreen.V5.Api.Card.CardEnvelope
    , now : Time.Posix
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V5.Shared.Msg
    | Page Evergreen.V5.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V5.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V5.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = ActiveSession Evergreen.V5.Api.User.User
    | PageMsg Evergreen.V5.Gen.Pages.Msg
    | NoOpToFrontend
