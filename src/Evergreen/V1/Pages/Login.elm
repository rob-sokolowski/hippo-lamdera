module Evergreen.V1.Pages.Login exposing (..)

import Evergreen.V1.Api.Data
import Evergreen.V1.Api.User


type alias Model = 
    { user : (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.User.User)
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.User.User)