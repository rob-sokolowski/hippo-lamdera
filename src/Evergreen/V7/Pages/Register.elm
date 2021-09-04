module Evergreen.V7.Pages.Register exposing (..)

import Evergreen.V7.Api.Data
import Evergreen.V7.Api.User


type alias Model = 
    { user : (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.User.User)
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
    | GotUser (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.User.User)