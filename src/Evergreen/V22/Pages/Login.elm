module Evergreen.V22.Pages.Login exposing (..)

import Evergreen.V22.Api.Data
import Evergreen.V22.Api.User


type alias Model =
    { user : Evergreen.V22.Api.Data.Data Evergreen.V22.Api.User.User
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V22.Api.Data.Data Evergreen.V22.Api.User.User)
