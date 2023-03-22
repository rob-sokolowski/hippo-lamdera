module Evergreen.V43.Pages.Login exposing (..)

import Evergreen.V43.Api.Data
import Evergreen.V43.Api.User
import Evergreen.V43.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V43.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V43.Api.Data.Data Evergreen.V43.Api.User.User)
