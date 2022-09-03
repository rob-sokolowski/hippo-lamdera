module Evergreen.V37.Pages.Login exposing (..)

import Evergreen.V37.Api.Data
import Evergreen.V37.Api.User
import Evergreen.V37.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V37.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V37.Api.Data.Data Evergreen.V37.Api.User.User)
