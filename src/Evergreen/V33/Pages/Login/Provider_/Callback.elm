module Evergreen.V33.Pages.Login.Provider_.Callback exposing (..)

import Evergreen.V33.Api.Data
import Evergreen.V33.Api.User
import Evergreen.V33.Auth.Common
import Url


type alias Model =
    { authFlow : Evergreen.V33.Auth.Common.Flow
    , authRedirectBaseUrl : Url.Url
    }


type Msg
    = GotUser (Evergreen.V33.Api.Data.Data Evergreen.V33.Api.User.User)
