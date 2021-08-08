module Evergreen.V2.Pages.Editor exposing (..)

import Evergreen.V2.Api.Article
import Evergreen.V2.Api.Data
import Evergreen.V2.Api.User
import Evergreen.V2.Components.Editor


type alias Model =
    { form : Evergreen.V2.Components.Editor.Form
    , article : Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Article
    }


type Msg
    = SubmittedForm Evergreen.V2.Api.User.User
    | Updated Evergreen.V2.Components.Editor.Field String
    | GotArticle (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Article)
