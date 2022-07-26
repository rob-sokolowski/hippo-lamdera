module Evergreen.V25.Shared exposing (..)

import Evergreen.V25.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V25.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V25.Api.User.User
    | SetTimeZoneToLocale Time.Zone
