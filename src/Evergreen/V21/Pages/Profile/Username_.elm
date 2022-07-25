module Evergreen.V21.Pages.Profile.Username_ exposing (..)

import Evergreen.V21.Api.Data
import Evergreen.V21.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model =
    { username : String
    , profile : Evergreen.V21.Api.Data.Data Evergreen.V21.Api.Profile.Profile
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V21.Api.Data.Data Evergreen.V21.Api.Profile.Profile)
