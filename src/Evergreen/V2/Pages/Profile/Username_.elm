module Evergreen.V2.Pages.Profile.Username_ exposing (..)

import Evergreen.V2.Api.Article
import Evergreen.V2.Api.Data
import Evergreen.V2.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model =
    { username : String
    , profile : Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Profile.Profile
    , listing : Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Listing
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Profile.Profile)
    | GotArticles (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Listing)
    | Clicked Tab
    | UpdatedArticle (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Article)
    | ClickedPage Int
