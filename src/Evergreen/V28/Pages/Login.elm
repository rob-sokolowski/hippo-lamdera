module Evergreen.V28.Pages.Login exposing (..)

import Evergreen.V28.Api.Data
import Evergreen.V28.Api.User
import Evergreen.V28.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V28.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V28.Api.Data.Data Evergreen.V28.Api.User.User)
