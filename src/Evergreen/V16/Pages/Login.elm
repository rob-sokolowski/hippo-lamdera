module Evergreen.V16.Pages.Login exposing (..)

import Evergreen.V16.Api.Data
import Evergreen.V16.Api.User


type alias Model =
    { user : Evergreen.V16.Api.Data.Data Evergreen.V16.Api.User.User
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V16.Api.Data.Data Evergreen.V16.Api.User.User)
