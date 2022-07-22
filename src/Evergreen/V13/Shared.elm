module Evergreen.V13.Shared exposing (..)

import Evergreen.V13.Api.User
import Time


type alias Model = 
    { user : (Maybe Evergreen.V13.Api.User.User)
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V13.Api.User.User
    | SetTimeZoneToLocale Time.Zone