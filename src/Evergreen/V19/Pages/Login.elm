module Evergreen.V19.Pages.Login exposing (..)

import Evergreen.V19.Api.Data
import Evergreen.V19.Api.User


type alias Model =
    { user : Evergreen.V19.Api.Data.Data Evergreen.V19.Api.User.User
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V19.Api.Data.Data Evergreen.V19.Api.User.User)
