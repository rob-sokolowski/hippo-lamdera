module Evergreen.V45.Shared exposing (..)

import Evergreen.V45.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V45.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V45.Api.User.User
    | SetTimeZoneToLocale Time.Zone
