module Evergreen.V2.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V2.Api.Article
import Evergreen.V2.Api.Article.Comment
import Evergreen.V2.Api.User
import Evergreen.V2.Bridge
import Evergreen.V2.Gen.Pages
import Evergreen.V2.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V2.Shared.Model
    , page : Evergreen.V2.Gen.Pages.Model
    }


type alias Session =
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : Dict.Dict Lamdera.SessionId Session
    , users : Dict.Dict Int Evergreen.V2.Api.User.UserFull
    , articles : Dict.Dict Evergreen.V2.Api.Article.Slug Evergreen.V2.Api.Article.ArticleStore
    , comments : Dict.Dict Evergreen.V2.Api.Article.Slug (Dict.Dict Int Evergreen.V2.Api.Article.Comment.Comment)
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V2.Shared.Msg
    | Page Evergreen.V2.Gen.Pages.Msg
    | Noop


type alias ToBackend =
    Evergreen.V2.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V2.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | ArticleCreated
        Time.Posix
        (Maybe Evergreen.V2.Api.User.UserFull)
        Lamdera.ClientId
        { title : String
        , description : String
        , body : String
        , tags : List String
        }
    | NoOpBackendMsg


type ToFrontend
    = ActiveSession Evergreen.V2.Api.User.User
    | PageMsg Evergreen.V2.Gen.Pages.Msg
    | NoOpToFrontend
