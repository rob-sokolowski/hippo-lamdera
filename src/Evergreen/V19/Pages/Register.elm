module Evergreen.V19.Pages.Register exposing (..)

import Evergreen.V19.Api.Data
import Evergreen.V19.Api.User


type alias Model =
    { user : Evergreen.V19.Api.Data.Data Evergreen.V19.Api.User.User
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
    | GotUser (Evergreen.V19.Api.Data.Data Evergreen.V19.Api.User.User)
