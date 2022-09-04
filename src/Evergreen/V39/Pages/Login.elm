module Evergreen.V39.Pages.Login exposing (..)

import Evergreen.V39.Api.Data
import Evergreen.V39.Api.User
import Evergreen.V39.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V39.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V39.Api.Data.Data Evergreen.V39.Api.User.User)
