module Evergreen.V30.Pages.Login exposing (..)

import Evergreen.V30.Api.Data
import Evergreen.V30.Api.User
import Evergreen.V30.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V30.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V30.Api.Data.Data Evergreen.V30.Api.User.User)
