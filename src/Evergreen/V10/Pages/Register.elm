module Evergreen.V10.Pages.Register exposing (..)

import Evergreen.V10.Api.Data
import Evergreen.V10.Api.User


type alias Model = 
    { user : (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.User.User)
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
    | GotUser (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.User.User)