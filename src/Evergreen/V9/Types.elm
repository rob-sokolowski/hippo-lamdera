module Evergreen.V9.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V9.Api.Card
import Evergreen.V9.Api.User
import Evergreen.V9.Bridge
import Evergreen.V9.Gen.Pages
import Evergreen.V9.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V9.Shared.Model
    , page : Evergreen.V9.Gen.Pages.Model
    }


type alias Session = 
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : (Dict.Dict Lamdera.SessionId Session)
    , users : (Dict.Dict Int Evergreen.V9.Api.User.UserFull)
    , cards : (Dict.Dict Evergreen.V9.Api.Card.CardId Evergreen.V9.Api.Card.CardEnvelope)
    , now : Time.Posix
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V9.Shared.Msg
    | Page Evergreen.V9.Gen.Pages.Msg
    | Noop


type alias ToBackend =Evergreen.V9.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V9.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = ActiveSession Evergreen.V9.Api.User.User
    | PageMsg Evergreen.V9.Gen.Pages.Msg
    | NoOpToFrontend