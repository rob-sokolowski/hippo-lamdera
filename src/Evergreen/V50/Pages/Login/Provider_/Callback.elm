module Evergreen.V50.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V50.Api.Data
import Evergreen.V50.Api.User
import Evergreen.V50.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V50.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V50.Api.Data.Data Evergreen.V50.Api.User.User)
