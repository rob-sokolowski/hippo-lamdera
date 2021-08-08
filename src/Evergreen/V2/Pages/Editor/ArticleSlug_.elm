module Evergreen.V2.Pages.Editor.ArticleSlug_ exposing (..)

import Evergreen.V2.Api.Article
import Evergreen.V2.Api.Data
import Evergreen.V2.Api.User
import Evergreen.V2.Components.Editor


type alias Model =
    { slug : String
    , form : Maybe Evergreen.V2.Components.Editor.Form
    , article : Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Article
    }


type Msg
    = SubmittedForm Evergreen.V2.Api.User.User Evergreen.V2.Components.Editor.Form
    | Updated Evergreen.V2.Components.Editor.Field String
    | UpdatedArticle (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Article)
    | LoadedInitialArticle (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Article)
