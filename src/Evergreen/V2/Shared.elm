module Evergreen.V2.Shared exposing (..)

import Evergreen.V2.Api.User


type alias Model =
    { user : Maybe Evergreen.V2.Api.User.User
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V2.Api.User.User
