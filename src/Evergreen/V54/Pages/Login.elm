module Evergreen.V54.Pages.Login exposing (..)

import Evergreen.V54.Api.Data
import Evergreen.V54.Api.User
import Evergreen.V54.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V54.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V54.Api.Data.Data Evergreen.V54.Api.User.User)
