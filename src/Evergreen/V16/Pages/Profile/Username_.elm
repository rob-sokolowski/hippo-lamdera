module Evergreen.V16.Pages.Profile.Username_ exposing (..)

import Evergreen.V16.Api.Data
import Evergreen.V16.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model =
    { username : String
    , profile : Evergreen.V16.Api.Data.Data Evergreen.V16.Api.Profile.Profile
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V16.Api.Data.Data Evergreen.V16.Api.Profile.Profile)
