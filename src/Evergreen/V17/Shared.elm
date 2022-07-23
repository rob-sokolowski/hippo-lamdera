module Evergreen.V17.Shared exposing (..)

import Evergreen.V17.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V17.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V17.Api.User.User
    | SetTimeZoneToLocale Time.Zone
