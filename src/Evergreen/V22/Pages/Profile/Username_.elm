module Evergreen.V22.Pages.Profile.Username_ exposing (..)

import Evergreen.V22.Api.Data
import Evergreen.V22.Api.Profile


type Tab
    = MyArticles
    | FavoritedArticles


type alias Model =
    { username : String
    , profile : Evergreen.V22.Api.Data.Data Evergreen.V22.Api.Profile.Profile
    , selectedTab : Tab
    , page : Int
    }


type Msg
    = GotProfile (Evergreen.V22.Api.Data.Data Evergreen.V22.Api.Profile.Profile)
