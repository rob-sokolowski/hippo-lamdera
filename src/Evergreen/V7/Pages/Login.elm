module Evergreen.V7.Pages.Login exposing (..)

import Evergreen.V7.Api.Data
import Evergreen.V7.Api.User


type alias Model = 
    { user : (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.User.User)
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.User.User)