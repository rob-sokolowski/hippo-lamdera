module Evergreen.V1.Shared exposing (..)

import Evergreen.V1.Api.User


type alias Model = 
    { user : (Maybe Evergreen.V1.Api.User.User)
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V1.Api.User.User