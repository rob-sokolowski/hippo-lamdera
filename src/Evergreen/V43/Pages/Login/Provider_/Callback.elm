module Evergreen.V43.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V43.Api.Data
import Evergreen.V43.Api.User
import Evergreen.V43.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V43.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V43.Api.Data.Data Evergreen.V43.Api.User.User)
