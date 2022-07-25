module Evergreen.V21.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V21.Api.Card
import Evergreen.V21.Api.User
import Evergreen.V21.Bridge
import Evergreen.V21.Gen.Pages
import Evergreen.V21.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V21.Shared.Model
    , page : Evergreen.V21.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V21.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V21.Api.Card.CardId Evergreen.V21.Api.Card.CardEnvelope
    , now : Time.Posix
    , nextCardId : Int
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V21.Shared.Msg
    | Page Evergreen.V21.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V21.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V21.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix
    | IncrementCardId


type ToFrontend
    = ActiveSession Evergreen.V21.Api.User.User
    | PageMsg Evergreen.V21.Gen.Pages.Msg
    | NoOpToFrontend
