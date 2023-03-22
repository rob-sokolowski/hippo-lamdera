module Evergreen.V48.Pages.Login exposing (..)

import Evergreen.V48.Api.Data
import Evergreen.V48.Api.User
import Evergreen.V48.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V48.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V48.Api.Data.Data Evergreen.V48.Api.User.User)
