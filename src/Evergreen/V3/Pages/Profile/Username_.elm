module Evergreen.V3.Pages.Profile.Username_ exposing (..)

import Evergreen.V3.Api.Data
import Evergreen.V3.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model =
    { username : String
    , profile : Evergreen.V3.Api.Data.Data Evergreen.V3.Api.Profile.Profile
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V3.Api.Data.Data Evergreen.V3.Api.Profile.Profile)
