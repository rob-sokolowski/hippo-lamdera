module Evergreen.V30.Shared exposing (..)

import Evergreen.V30.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V30.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V30.Api.User.User
    | SetTimeZoneToLocale Time.Zone
