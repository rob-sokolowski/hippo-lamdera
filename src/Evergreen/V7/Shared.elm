module Evergreen.V7.Shared exposing (..)

import Evergreen.V7.Api.User


type alias Model = 
    { user : (Maybe Evergreen.V7.Api.User.User)
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V7.Api.User.User