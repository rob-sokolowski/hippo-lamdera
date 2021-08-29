module Evergreen.V5.Pages.Login exposing (..)

import Evergreen.V5.Api.Data
import Evergreen.V5.Api.User


type alias Model =
    { user : Evergreen.V5.Api.Data.Data Evergreen.V5.Api.User.User
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V5.Api.Data.Data Evergreen.V5.Api.User.User)
