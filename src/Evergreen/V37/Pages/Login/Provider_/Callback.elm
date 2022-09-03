module Evergreen.V37.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V37.Api.Data
import Evergreen.V37.Api.User
import Evergreen.V37.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V37.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V37.Api.Data.Data Evergreen.V37.Api.User.User)
