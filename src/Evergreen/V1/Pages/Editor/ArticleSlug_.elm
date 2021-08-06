module Evergreen.V1.Pages.Editor.ArticleSlug_ exposing (..)

import Evergreen.V1.Api.Article
import Evergreen.V1.Api.Data
import Evergreen.V1.Api.User
import Evergreen.V1.Components.Editor


type alias Model = 
    { slug : String
    , form : (Maybe Evergreen.V1.Components.Editor.Form)
    , article : (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Article)
    }


type Msg
    = SubmittedForm Evergreen.V1.Api.User.User Evergreen.V1.Components.Editor.Form
    | Updated Evergreen.V1.Components.Editor.Field String
    | UpdatedArticle (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Article)
    | LoadedInitialArticle (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Article)