module Evergreen.V42.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V42.Api.Data
import Evergreen.V42.Api.User
import Evergreen.V42.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V42.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V42.Api.Data.Data Evergreen.V42.Api.User.User)
