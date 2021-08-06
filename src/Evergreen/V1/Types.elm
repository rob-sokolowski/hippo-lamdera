module Evergreen.V1.Types exposing (..)

import Browser
import Browser.Navigation
import Dict
import Evergreen.V1.Api.Article
import Evergreen.V1.Api.Article.Comment
import Evergreen.V1.Api.User
import Evergreen.V1.Bridge
import Evergreen.V1.Gen.Pages
import Evergreen.V1.Shared
import Lamdera
import Time
import Url


type alias FrontendModel =
    { url : Url.Url
    , key : Browser.Navigation.Key
    , shared : Evergreen.V1.Shared.Model
    , page : Evergreen.V1.Gen.Pages.Model
    }


type alias Session = 
    { userId : Int
    , expires : Time.Posix
    }


type alias BackendModel =
    { sessions : (Dict.Dict Lamdera.SessionId Session)
    , users : (Dict.Dict Int Evergreen.V1.Api.User.UserFull)
    , articles : (Dict.Dict Evergreen.V1.Api.Article.Slug Evergreen.V1.Api.Article.ArticleStore)
    , comments : (Dict.Dict Evergreen.V1.Api.Article.Slug (Dict.Dict Int Evergreen.V1.Api.Article.Comment.Comment))
    }


type FrontendMsg
    = ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest
    | Shared Evergreen.V1.Shared.Msg
    | Page Evergreen.V1.Gen.Pages.Msg
    | Noop


type alias ToBackend =Evergreen.V1.Bridge.ToBackend


type BackendMsg
    = CheckSession Lamdera.SessionId Lamdera.ClientId
    | RenewSession Evergreen.V1.Api.User.UserId Lamdera.SessionId Lamdera.ClientId Time.Posix
    | ArticleCreated Time.Posix (Maybe Evergreen.V1.Api.User.UserFull) Lamdera.ClientId 
    { title : String
    , description : String
    , body : String
    , tags : (List String)
    }
    | ArticleCommentCreated Time.Posix (Maybe Evergreen.V1.Api.User.UserFull) Lamdera.ClientId Evergreen.V1.Api.Article.Slug 
    { body : String
    }
    | NoOpBackendMsg


type ToFrontend
    = ActiveSession Evergreen.V1.Api.User.User
    | PageMsg Evergreen.V1.Gen.Pages.Msg
    | NoOpToFrontend