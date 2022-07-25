module Evergreen.V21.Pages.Register exposing (..)

import Evergreen.V21.Api.Data
import Evergreen.V21.Api.User


type alias Model =
    { user : Evergreen.V21.Api.Data.Data Evergreen.V21.Api.User.User
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
    | GotUser (Evergreen.V21.Api.Data.Data Evergreen.V21.Api.User.User)
