module Evergreen.V5.Shared exposing (..)

import Evergreen.V5.Api.User


type alias Model =
    { user : Maybe Evergreen.V5.Api.User.User
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V5.Api.User.User
