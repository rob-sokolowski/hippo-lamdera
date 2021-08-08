module Evergreen.V2.Pages.Login exposing (..)

import Evergreen.V2.Api.Data
import Evergreen.V2.Api.User


type alias Model =
    { user : Evergreen.V2.Api.Data.Data Evergreen.V2.Api.User.User
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.User.User)
