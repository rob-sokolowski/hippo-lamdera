module Evergreen.V42.Pages.Login exposing (..)

import Evergreen.V42.Api.Data
import Evergreen.V42.Api.User
import Evergreen.V42.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V42.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V42.Api.Data.Data Evergreen.V42.Api.User.User)
