module Evergreen.V13.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V13.Api.Card
import Evergreen.V13.Api.User
import Evergreen.V13.Bridge
import Evergreen.V13.Gen.Pages
import Evergreen.V13.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V13.Shared.Model
    , page : Evergreen.V13.Gen.Pages.Model
    }


type alias Session = 
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : (Dict.Dict Lamdera.SessionId Session)
    , users : (Dict.Dict Int Evergreen.V13.Api.User.UserFull)
    , cards : (Dict.Dict Evergreen.V13.Api.Card.CardId Evergreen.V13.Api.Card.CardEnvelope)
    , now : Time.Posix
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V13.Shared.Msg
    | Page Evergreen.V13.Gen.Pages.Msg
    | Noop


type alias ToBackend =Evergreen.V13.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V13.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | NoOpBackendMsg
    | Tick Time.Posix


type ToFrontend
    = ActiveSession Evergreen.V13.Api.User.User
    | PageMsg Evergreen.V13.Gen.Pages.Msg
    | NoOpToFrontend