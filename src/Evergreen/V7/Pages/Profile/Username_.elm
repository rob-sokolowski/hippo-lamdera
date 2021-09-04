module Evergreen.V7.Pages.Profile.Username_ exposing (..)

import Evergreen.V7.Api.Data
import Evergreen.V7.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model = 
    { username : String
    , profile : (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.Profile.Profile)
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.Profile.Profile)