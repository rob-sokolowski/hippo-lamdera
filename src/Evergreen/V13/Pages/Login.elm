module Evergreen.V13.Pages.Login exposing (..)

import Evergreen.V13.Api.Data
import Evergreen.V13.Api.User


type alias Model = 
    { user : (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.User.User)
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.User.User)