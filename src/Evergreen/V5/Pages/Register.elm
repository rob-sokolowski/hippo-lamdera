module Evergreen.V5.Pages.Register exposing (..)

import Evergreen.V5.Api.Data
import Evergreen.V5.Api.User


type alias Model = 
    { user : (Evergreen.V5.Api.Data.Data Evergreen.V5.Api.User.User)
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
    | GotUser (Evergreen.V5.Api.Data.Data Evergreen.V5.Api.User.User)