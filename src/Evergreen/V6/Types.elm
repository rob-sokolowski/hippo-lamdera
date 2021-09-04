module Evergreen.V6.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V6.Api.Card
import Evergreen.V6.Api.User
import Evergreen.V6.Bridge
import Evergreen.V6.Gen.Pages
import Evergreen.V6.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V6.Shared.Model
    , page : Evergreen.V6.Gen.Pages.Model
    }


type alias Session = 
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : (Dict.Dict Lamdera.SessionId Session)
    , users : (Dict.Dict Int Evergreen.V6.Api.User.UserFull)
    , cards : (Dict.Dict Evergreen.V6.Api.Card.CardId Evergreen.V6.Api.Card.CardEnvelope)
    , now : Time.Posix
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V6.Shared.Msg
    | Page Evergreen.V6.Gen.Pages.Msg
    | Noop


type alias ToBackend =Evergreen.V6.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V6.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = ActiveSession Evergreen.V6.Api.User.User
    | PageMsg Evergreen.V6.Gen.Pages.Msg
    | NoOpToFrontend