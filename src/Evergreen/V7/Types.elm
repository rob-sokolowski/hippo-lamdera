module Evergreen.V7.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V7.Api.Card
import Evergreen.V7.Api.User
import Evergreen.V7.Bridge
import Evergreen.V7.Gen.Pages
import Evergreen.V7.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V7.Shared.Model
    , page : Evergreen.V7.Gen.Pages.Model
    }


type alias Session = 
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : (Dict.Dict Lamdera.SessionId Session)
    , users : (Dict.Dict Int Evergreen.V7.Api.User.UserFull)
    , cards : (Dict.Dict Evergreen.V7.Api.Card.CardId Evergreen.V7.Api.Card.CardEnvelope)
    , now : Time.Posix
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V7.Shared.Msg
    | Page Evergreen.V7.Gen.Pages.Msg
    | Noop


type alias ToBackend =Evergreen.V7.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V7.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = ActiveSession Evergreen.V7.Api.User.User
    | PageMsg Evergreen.V7.Gen.Pages.Msg
    | NoOpToFrontend