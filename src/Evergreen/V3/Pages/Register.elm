module Evergreen.V3.Pages.Register exposing (..)

import Evergreen.V3.Api.Data
import Evergreen.V3.Api.User


type alias Model =
    { user : Evergreen.V3.Api.Data.Data Evergreen.V3.Api.User.User
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
    | GotUser (Evergreen.V3.Api.Data.Data Evergreen.V3.Api.User.User)
