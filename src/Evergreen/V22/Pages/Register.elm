module Evergreen.V22.Pages.Register exposing (..)

import Evergreen.V22.Api.Data
import Evergreen.V22.Api.User


type FormState
    = Incomplete
    | PasswordMismatch
    | Complete


type alias Model =
    { user : Evergreen.V22.Api.Data.Data Evergreen.V22.Api.User.User
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
    | GotUser (Evergreen.V22.Api.Data.Data Evergreen.V22.Api.User.User)
