module Evergreen.V9.Pages.Login exposing (..)

import Evergreen.V9.Api.Data
import Evergreen.V9.Api.User


type alias Model = 
    { user : (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.User.User)
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.User.User)