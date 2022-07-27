module Evergreen.V28.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V28.Api.Data
import Evergreen.V28.Api.User
import Evergreen.V28.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V28.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V28.Api.Data.Data Evergreen.V28.Api.User.User)
