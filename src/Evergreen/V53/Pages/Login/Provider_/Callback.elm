module Evergreen.V53.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V53.Api.Data
import Evergreen.V53.Api.User
import Evergreen.V53.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V53.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V53.Api.Data.Data Evergreen.V53.Api.User.User)
