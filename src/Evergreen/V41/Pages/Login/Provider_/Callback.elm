module Evergreen.V41.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V41.Api.Data
import Evergreen.V41.Api.User
import Evergreen.V41.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V41.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V41.Api.Data.Data Evergreen.V41.Api.User.User)
