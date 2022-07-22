module Evergreen.V13.Pages.Register exposing (..)

import Evergreen.V13.Api.Data
import Evergreen.V13.Api.User


type alias Model = 
    { user : (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.User.User)
    , displayName : String
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
    | GotUser (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.User.User)