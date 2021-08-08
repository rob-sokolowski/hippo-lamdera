module Evergreen.V2.Pages.Register exposing (..)

import Evergreen.V2.Api.Data
import Evergreen.V2.Api.User


type alias Model =
    { user : Evergreen.V2.Api.Data.Data Evergreen.V2.Api.User.User
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
    | GotUser (Evergreen.V2.Api.Data.Data Evergreen.V2.Api.User.User)
