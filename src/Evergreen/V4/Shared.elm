module Evergreen.V4.Shared exposing (..)

import Evergreen.V4.Api.User


type alias Model =
    { user : Maybe Evergreen.V4.Api.User.User
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V4.Api.User.User
