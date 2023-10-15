module Evergreen.V60.Shared exposing (..)

import Evergreen.V60.Api.User
import Time


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V60.Api.User.User
    | SetTimeZoneToLocale Time.Zone


type alias Model =
    { user : Maybe Evergreen.V60.Api.User.User
    , zone : Time.Zone
    }
