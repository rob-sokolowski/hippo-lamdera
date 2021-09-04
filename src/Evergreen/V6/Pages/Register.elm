module Evergreen.V6.Pages.Register exposing (..)

import Evergreen.V6.Api.Data
import Evergreen.V6.Api.User


type alias Model = 
    { user : (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.User.User)
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
    | GotUser (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.User.User)