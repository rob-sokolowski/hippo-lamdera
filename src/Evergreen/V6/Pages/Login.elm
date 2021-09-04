module Evergreen.V6.Pages.Login exposing (..)

import Evergreen.V6.Api.Data
import Evergreen.V6.Api.User


type alias Model = 
    { user : (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.User.User)
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.User.User)