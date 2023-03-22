module Evergreen.V48.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V48.Api.Data
import Evergreen.V48.Api.User
import Evergreen.V48.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V48.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V48.Api.Data.Data Evergreen.V48.Api.User.User)
