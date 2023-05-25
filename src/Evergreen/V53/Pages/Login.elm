module Evergreen.V53.Pages.Login exposing (..)

import Evergreen.V53.Api.Data
import Evergreen.V53.Api.User
import Evergreen.V53.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V53.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V53.Api.Data.Data Evergreen.V53.Api.User.User)
