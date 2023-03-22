module Evergreen.V45.Pages.Login exposing (..)

import Evergreen.V45.Api.Data
import Evergreen.V45.Api.User
import Evergreen.V45.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V45.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V45.Api.Data.Data Evergreen.V45.Api.User.User)
