module Evergreen.V17.Pages.Login exposing (..)

import Evergreen.V17.Api.Data
import Evergreen.V17.Api.User


type alias Model =
    { user : Evergreen.V17.Api.Data.Data Evergreen.V17.Api.User.User
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V17.Api.Data.Data Evergreen.V17.Api.User.User)
