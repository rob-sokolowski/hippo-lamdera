module Evergreen.V16.Pages.Register exposing (..)

import Evergreen.V16.Api.Data
import Evergreen.V16.Api.User


type alias Model =
    { user : Evergreen.V16.Api.Data.Data Evergreen.V16.Api.User.User
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
    | GotUser (Evergreen.V16.Api.Data.Data Evergreen.V16.Api.User.User)
