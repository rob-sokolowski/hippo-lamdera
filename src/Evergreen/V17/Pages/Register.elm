module Evergreen.V17.Pages.Register exposing (..)

import Evergreen.V17.Api.Data
import Evergreen.V17.Api.User


type alias Model =
    { user : Evergreen.V17.Api.Data.Data Evergreen.V17.Api.User.User
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
    | GotUser (Evergreen.V17.Api.Data.Data Evergreen.V17.Api.User.User)
