module Evergreen.V56.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V56.Api.Data
import Evergreen.V56.Api.User
import Evergreen.V56.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V56.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V56.Api.Data.Data Evergreen.V56.Api.User.User)
