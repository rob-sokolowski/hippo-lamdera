module Evergreen.V5.Pages.Profile.Username_ exposing (..)

import Evergreen.V5.Api.Data
import Evergreen.V5.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model = 
    { username : String
    , profile : (Evergreen.V5.Api.Data.Data Evergreen.V5.Api.Profile.Profile)
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V5.Api.Data.Data Evergreen.V5.Api.Profile.Profile)