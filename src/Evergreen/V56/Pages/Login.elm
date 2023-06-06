module Evergreen.V56.Pages.Login exposing (..)

import Evergreen.V56.Api.Data
import Evergreen.V56.Api.User
import Evergreen.V56.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V56.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V56.Api.Data.Data Evergreen.V56.Api.User.User)
