module Evergreen.V3.Pages.Login exposing (..)

import Evergreen.V3.Api.Data
import Evergreen.V3.Api.User


type alias Model =
    { user : Evergreen.V3.Api.Data.Data Evergreen.V3.Api.User.User
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V3.Api.Data.Data Evergreen.V3.Api.User.User)
