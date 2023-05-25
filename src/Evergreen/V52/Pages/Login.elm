module Evergreen.V52.Pages.Login exposing (..)

import Evergreen.V52.Api.Data
import Evergreen.V52.Api.User
import Evergreen.V52.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V52.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V52.Api.Data.Data Evergreen.V52.Api.User.User)
