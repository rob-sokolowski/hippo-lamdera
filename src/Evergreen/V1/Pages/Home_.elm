module Evergreen.V1.Pages.Home_ exposing (..)

import Evergreen.V1.Api.Article
import Evergreen.V1.Api.Data
import Evergreen.V1.Api.User


type alias Tag = String


type Tab
    = FeedFor Evergreen.V1.Api.User.User
    | Global
    | TagFilter Tag


type alias Model = 
    { listing : (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Listing)
    , page : Int
    , tags : (Evergreen.V1.Api.Data.Data (List Tag))
    , activeTab : Tab
    }


type Msg
    = GotArticles (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Listing)
    | GotTags (Evergreen.V1.Api.Data.Data (List Tag))
    | SelectedTab Tab
    | ClickedFavorite Evergreen.V1.Api.User.User Evergreen.V1.Api.Article.Article
    | ClickedUnfavorite Evergreen.V1.Api.User.User Evergreen.V1.Api.Article.Article
    | ClickedPage Int
    | UpdatedArticle (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.Article.Article)