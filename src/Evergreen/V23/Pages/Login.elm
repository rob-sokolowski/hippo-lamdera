module Evergreen.V23.Pages.Login exposing (..)

import Evergreen.V23.Api.Data
import Evergreen.V23.Api.User


type alias Model =
    { user : Evergreen.V23.Api.Data.Data Evergreen.V23.Api.User.User
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V23.Api.Data.Data Evergreen.V23.Api.User.User)
