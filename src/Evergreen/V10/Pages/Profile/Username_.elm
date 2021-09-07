module Evergreen.V10.Pages.Profile.Username_ exposing (..)

import Evergreen.V10.Api.Data
import Evergreen.V10.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model = 
    { username : String
    , profile : (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.Profile.Profile)
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.Profile.Profile)