module Evergreen.V10.Pages.Login exposing (..)

import Evergreen.V10.Api.Data
import Evergreen.V10.Api.User


type alias Model = 
    { user : (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.User.User)
    , email : String
    , password : String
    }


type Field
    = Email
    | Password


type Msg
    = Updated Field String
    | AttemptedSignIn
    | GotUser (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.User.User)