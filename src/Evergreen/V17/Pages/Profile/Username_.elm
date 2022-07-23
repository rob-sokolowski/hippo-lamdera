module Evergreen.V17.Pages.Profile.Username_ exposing (..)

import Evergreen.V17.Api.Data
import Evergreen.V17.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model =
    { username : String
    , profile : Evergreen.V17.Api.Data.Data Evergreen.V17.Api.Profile.Profile
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V17.Api.Data.Data Evergreen.V17.Api.Profile.Profile)
