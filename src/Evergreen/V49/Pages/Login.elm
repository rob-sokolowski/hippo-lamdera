module Evergreen.V49.Pages.Login exposing (..)

import Evergreen.V49.Api.Data
import Evergreen.V49.Api.User
import Evergreen.V49.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V49.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V49.Api.Data.Data Evergreen.V49.Api.User.User)
