module Evergreen.V60.Pages.Login exposing (..)

import Evergreen.V60.Api.Data
import Evergreen.V60.Api.User
import Evergreen.V60.Auth.Common
import Url


type Msg
    = GoogleOAuthSignInRequested
    | GitHubOAuthSignInRequested
    | GotUser (Evergreen.V60.Api.Data.Data Evergreen.V60.Api.User.User)


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V60.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }
