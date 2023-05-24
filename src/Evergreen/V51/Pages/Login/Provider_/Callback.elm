module Evergreen.V51.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V51.Api.Data
import Evergreen.V51.Api.User
import Evergreen.V51.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V51.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V51.Api.Data.Data Evergreen.V51.Api.User.User)
