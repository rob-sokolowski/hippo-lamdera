module Evergreen.V41.Pages.Login exposing (..)

import Evergreen.V41.Api.Data
import Evergreen.V41.Api.User
import Evergreen.V41.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V41.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V41.Api.Data.Data Evergreen.V41.Api.User.User)
