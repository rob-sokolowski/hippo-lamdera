module Evergreen.V40.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V40.Api.Data
import Evergreen.V40.Api.User
import Evergreen.V40.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V40.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V40.Api.Data.Data Evergreen.V40.Api.User.User)
