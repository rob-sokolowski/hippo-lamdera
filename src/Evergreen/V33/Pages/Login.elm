module Evergreen.V33.Pages.Login exposing (..)

import Evergreen.V33.Api.Data
import Evergreen.V33.Api.User
import Evergreen.V33.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V33.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V33.Api.Data.Data Evergreen.V33.Api.User.User)
