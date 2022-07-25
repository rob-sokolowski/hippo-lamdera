module Evergreen.V22.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V22.Api.Card
import Evergreen.V22.Api.User
import Evergreen.V22.Bridge
import Evergreen.V22.Gen.Pages
import Evergreen.V22.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V22.Shared.Model
    , page : Evergreen.V22.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V22.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V22.Api.Card.CardId Evergreen.V22.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V22.Shared.Msg
    | Page Evergreen.V22.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V22.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V22.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix
    | IncrementCardId


type ToFrontend
    = ActiveSession Evergreen.V22.Api.User.User
    | PageMsg Evergreen.V22.Gen.Pages.Msg
    | NoOpToFrontend
