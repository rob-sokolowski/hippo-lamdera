module Evergreen.V4.Pages.Profile.Username_ exposing (..)

import Evergreen.V4.Api.Data
import Evergreen.V4.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model =
    { username : String
    , profile : Evergreen.V4.Api.Data.Data Evergreen.V4.Api.Profile.Profile
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V4.Api.Data.Data Evergreen.V4.Api.Profile.Profile)
