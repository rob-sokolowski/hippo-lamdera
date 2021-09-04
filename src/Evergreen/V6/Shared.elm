module Evergreen.V6.Shared exposing (..)

import Evergreen.V6.Api.User


type alias Model = 
    { user : (Maybe Evergreen.V6.Api.User.User)
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V6.Api.User.User