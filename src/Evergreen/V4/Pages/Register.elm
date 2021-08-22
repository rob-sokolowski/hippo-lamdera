module Evergreen.V4.Pages.Register exposing (..)

import Evergreen.V4.Api.Data
import Evergreen.V4.Api.User


type alias Model =
    { user : Evergreen.V4.Api.Data.Data Evergreen.V4.Api.User.User
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
    | GotUser (Evergreen.V4.Api.Data.Data Evergreen.V4.Api.User.User)
