module Evergreen.V4.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V4.Api.Card
import Evergreen.V4.Api.User
import Evergreen.V4.Bridge
import Evergreen.V4.Gen.Pages
import Evergreen.V4.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V4.Shared.Model
    , page : Evergreen.V4.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V4.Api.User.UserFull
    , cards : Dict.Dict Evergreen.V4.Api.Card.CardId Evergreen.V4.Api.Card.FlashCard
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V4.Shared.Msg
    | Page Evergreen.V4.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V4.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V4.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg


type ToFrontend
    = ActiveSession Evergreen.V4.Api.User.User
    | PageMsg Evergreen.V4.Gen.Pages.Msg
    | NoOpToFrontend
