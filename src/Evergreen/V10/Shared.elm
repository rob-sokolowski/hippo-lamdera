module Evergreen.V10.Shared exposing (..)

import Evergreen.V10.Api.User
import Time


type alias Model = 
    { user : (Maybe Evergreen.V10.Api.User.User)
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V10.Api.User.User
    | SetTimeZoneToLocale Time.Zone