module Evergreen.V40.Pages.Login exposing (..)

import Evergreen.V40.Api.Data
import Evergreen.V40.Api.User
import Evergreen.V40.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V40.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V40.Api.Data.Data Evergreen.V40.Api.User.User)
