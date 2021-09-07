module Evergreen.V9.Pages.Register exposing (..)

import Evergreen.V9.Api.Data
import Evergreen.V9.Api.User


type alias Model = 
    { user : (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.User.User)
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
    | GotUser (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.User.User)