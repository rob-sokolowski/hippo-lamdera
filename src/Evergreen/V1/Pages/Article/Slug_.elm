module Evergreen.V1.Pages.Article.Slug_ exposing (..)

import Evergreen.V1.Api.Article
import Evergreen.V1.Api.Article.Comment
import Evergreen.V1.Api.Data
import Evergreen.V1.Api.Profile
import Evergreen.V1.Api.User


type alias Model = 
    { article : (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Article)
    , comments : (Evergreen.V1.Api.Data.Data (List Evergreen.V1.Api.Article.Comment.Comment))
    , commentText : String
    }


type Msg
    = GotArticle (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Article)
    | ClickedFavorite Evergreen.V1.Api.User.User Evergreen.V1.Api.Article.Article
    | ClickedUnfavorite Evergreen.V1.Api.User.User Evergreen.V1.Api.Article.Article
    | ClickedDeleteArticle Evergreen.V1.Api.User.User Evergreen.V1.Api.Article.Article
    | DeletedArticle (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Article)
    | GotAuthor (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Profile.Profile)
    | ClickedFollow Evergreen.V1.Api.User.User Evergreen.V1.Api.Profile.Profile
    | ClickedUnfollow Evergreen.V1.Api.User.User Evergreen.V1.Api.Profile.Profile
    | GotComments (Evergreen.V1.Api.Data.Data (List Evergreen.V1.Api.Article.Comment.Comment))
    | ClickedDeleteComment Evergreen.V1.Api.User.User Evergreen.V1.Api.Article.Article Evergreen.V1.Api.Article.Comment.Comment
    | DeletedComment (Evergreen.V1.Api.Data.Data Int)
    | SubmittedCommentForm Evergreen.V1.Api.User.User Evergreen.V1.Api.Article.Article
    | CreatedComment (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Comment.Comment)
    | UpdatedCommentText String