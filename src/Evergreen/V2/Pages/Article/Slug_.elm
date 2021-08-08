module Evergreen.V2.Pages.Article.Slug_ exposing (..)

import Evergreen.V2.Api.Article
import Evergreen.V2.Api.Article.Comment
import Evergreen.V2.Api.Data
import Evergreen.V2.Api.Profile
import Evergreen.V2.Api.User


type alias Model =
    { article : Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Article
    , comments : Evergreen.V2.Api.Data.Data (List Evergreen.V2.Api.Article.Comment.Comment)
    , commentText : String
    }


type Msg
    = GotArticle (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Article)
    | ClickedDeleteArticle Evergreen.V2.Api.User.User Evergreen.V2.Api.Article.Article
    | DeletedArticle (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Article)
    | GotAuthor (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Profile.Profile)
