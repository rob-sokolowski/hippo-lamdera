module Evergreen.V21.Pages.Login exposing (..)

import Evergreen.V21.Api.Data
import Evergreen.V21.Api.User


type alias Model =
    { user : Evergreen.V21.Api.Data.Data Evergreen.V21.Api.User.User
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V21.Api.Data.Data Evergreen.V21.Api.User.User)
