module Evergreen.V6.Pages.Profile.Username_ exposing (..)

import Evergreen.V6.Api.Data
import Evergreen.V6.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model = 
    { username : String
    , profile : (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.Profile.Profile)
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.Profile.Profile)