module Evergreen.V13.Pages.Profile.Username_ exposing (..)

import Evergreen.V13.Api.Data
import Evergreen.V13.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model = 
    { username : String
    , profile : (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.Profile.Profile)
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.Profile.Profile)