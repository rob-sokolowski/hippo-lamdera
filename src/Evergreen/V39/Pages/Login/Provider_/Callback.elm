module Evergreen.V39.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V39.Api.Data
import Evergreen.V39.Api.User
import Evergreen.V39.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V39.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V39.Api.Data.Data Evergreen.V39.Api.User.User)
