module Evergreen.V1.Pages.Register exposing (..)

import Evergreen.V1.Api.Data
import Evergreen.V1.Api.User


type alias Model = 
    { user : (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.User.User)
    , username : String
    , email : String
    , password : String
    }


type Field
    = Username
    | Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignUp
    | GotUser (Evergreen.V1.Api.Data.Data Evergreen.V1.Api.User.User)