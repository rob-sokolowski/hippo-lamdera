module Evergreen.V51.Pages.Login exposing (..)

import Evergreen.V51.Api.Data
import Evergreen.V51.Api.User
import Evergreen.V51.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V51.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V51.Api.Data.Data Evergreen.V51.Api.User.User)
