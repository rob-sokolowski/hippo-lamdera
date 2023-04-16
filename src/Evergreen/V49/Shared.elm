module Evergreen.V49.Shared exposing (..)

import Evergreen.V49.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V49.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V49.Api.User.User
    | SetTimeZoneToLocale Time.Zone
