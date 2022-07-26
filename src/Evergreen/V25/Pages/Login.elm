module Evergreen.V25.Pages.Login exposing (..)

import Evergreen.V25.Api.Data
import Evergreen.V25.Api.User
import Evergreen.V25.Auth.Common
import Url


type alias Model =
    { email : String
    , password : String
    , authFlow : Evergreen.V25.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GoogleOAuthSignInRequested
    | GotUser (Evergreen.V25.Api.Data.Data Evergreen.V25.Api.User.User)
