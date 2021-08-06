module Evergreen.V1.Pages.Profile.Username_ exposing (..)

import Evergreen.V1.Api.Article
import Evergreen.V1.Api.Data
import Evergreen.V1.Api.Profile
import Evergreen.V1.Api.User


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model =
    { username : String
    , profile : Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Profile.Profile
    , listing : Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Listing
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Profile.Profile)
    | GotArticles (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Listing)
    | Clicked Tab
    | ClickedFavorite Evergreen.V1.Api.User.User Evergreen.V1.Api.Article.Article
    | ClickedUnfavorite Evergreen.V1.Api.User.User Evergreen.V1.Api.Article.Article
    | UpdatedArticle (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Article)
    | ClickedFollow Evergreen.V1.Api.User.User Evergreen.V1.Api.Profile.Profile
    | ClickedUnfollow Evergreen.V1.Api.User.User Evergreen.V1.Api.Profile.Profile
    | ClickedPage Int
