module Evergreen.V3.Shared exposing (..)

import Evergreen.V3.Api.User


type alias Model =
    { user : Maybe Evergreen.V3.Api.User.User
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V3.Api.User.User
