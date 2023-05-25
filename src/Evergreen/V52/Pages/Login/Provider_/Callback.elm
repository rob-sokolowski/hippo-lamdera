module Evergreen.V52.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V52.Api.Data
import Evergreen.V52.Api.User
import Evergreen.V52.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V52.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V52.Api.Data.Data Evergreen.V52.Api.User.User)
