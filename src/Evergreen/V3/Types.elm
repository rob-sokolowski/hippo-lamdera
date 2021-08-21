module Evergreen.V3.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V3.Api.Card
import Evergreen.V3.Api.User
import Evergreen.V3.Bridge
import Evergreen.V3.Gen.Pages
import Evergreen.V3.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V3.Shared.Model
    , page : Evergreen.V3.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V3.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V3.Api.Card.CardId Evergreen.V3.Api.Card.FlashCard
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V3.Shared.Msg
    | Page Evergreen.V3.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V3.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V3.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg


type ToFrontend
    = ActiveSession Evergreen.V3.Api.User.User
    | PageMsg Evergreen.V3.Gen.Pages.Msg
    | NoOpToFrontend
