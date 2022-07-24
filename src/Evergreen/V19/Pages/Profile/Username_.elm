module Evergreen.V19.Pages.Profile.Username_ exposing (..)

import Evergreen.V19.Api.Data
import Evergreen.V19.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model =
    { username : String
    , profile : Evergreen.V19.Api.Data.Data Evergreen.V19.Api.Profile.Profile
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V19.Api.Data.Data Evergreen.V19.Api.Profile.Profile)
