module Evergreen.V1.Pages.Editor exposing (..)

import Evergreen.V1.Api.Article
import Evergreen.V1.Api.Data
import Evergreen.V1.Api.User
import Evergreen.V1.Components.Editor


type alias Model =
    { form : Evergreen.V1.Components.Editor.Form
    , article : Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Article
    }


type Msg
    = SubmittedForm Evergreen.V1.Api.User.User
    | Updated Evergreen.V1.Components.Editor.Field String
    | GotArticle (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Article)
