module Evergreen.V45.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V45.Api.Data
import Evergreen.V45.Api.User
import Evergreen.V45.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V45.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V45.Api.Data.Data Evergreen.V45.Api.User.User)
