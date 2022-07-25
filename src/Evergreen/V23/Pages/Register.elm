module Evergreen.V23.Pages.Register exposing (..)

import Evergreen.V23.Api.Data
import Evergreen.V23.Api.User


type FormState
    = Incomplete
    | PasswordMismatch
    | Complete


type alias Model =
    { user : Evergreen.V23.Api.Data.Data Evergreen.V23.Api.User.User
    , email : String
    , password : String
    , passwordConfirmed : String
    , formState : FormState
    }


type Field
    = Email
    | Password
    | PasswordConfirmation


type Msg
    = Updated Field String
    | AttemptedSignUp
    | GotUser (Evergreen.V23.Api.Data.Data Evergreen.V23.Api.User.User)
