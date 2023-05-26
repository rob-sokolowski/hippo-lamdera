module Evergreen.V54.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V54.Api.Data
import Evergreen.V54.Api.User
import Evergreen.V54.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V54.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V54.Api.Data.Data Evergreen.V54.Api.User.User)
