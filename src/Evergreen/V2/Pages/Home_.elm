module Evergreen.V2.Pages.Home_ exposing (..)

import Evergreen.V2.Api.Article
import Evergreen.V2.Api.Data
import Evergreen.V2.Api.User


type alias Tag =
    String


type Tab
    = FeedFor Evergreen.V2.Api.User.User
    | Global
    | TagFilter Tag


type alias Model =
    { listing : Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Listing
    , page : Int
    , tags : Evergreen.V2.Api.Data.Data (List Tag)
    , activeTab : Tab
    }


type Msg
    = GotArticles (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Listing)
    | GotTags (Evergreen.V2.Api.Data.Data (List Tag))
    | SelectedTab Tab
    | ClickedPage Int
    | UpdatedArticle (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.Article.Article)
