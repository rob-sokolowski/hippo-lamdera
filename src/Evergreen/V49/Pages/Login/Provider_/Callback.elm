module Evergreen.V49.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V49.Api.Data
import Evergreen.V49.Api.User
import Evergreen.V49.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V49.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V49.Api.Data.Data Evergreen.V49.Api.User.User)
