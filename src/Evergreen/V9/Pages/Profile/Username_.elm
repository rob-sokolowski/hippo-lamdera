module Evergreen.V9.Pages.Profile.Username_ exposing (..)

import Evergreen.V9.Api.Data
import Evergreen.V9.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model = 
    { username : String
    , profile : (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.Profile.Profile)
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.Profile.Profile)