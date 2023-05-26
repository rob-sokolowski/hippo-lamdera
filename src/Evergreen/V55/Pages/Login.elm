module Evergreen.V55.Pages.Login exposing (..)

import Evergreen.V55.Api.Data
import Evergreen.V55.Api.User
import Evergreen.V55.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V55.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V55.Api.Data.Data Evergreen.V55.Api.User.User)
