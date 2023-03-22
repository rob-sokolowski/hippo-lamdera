module Evergreen.V43.Shared exposing (..)

import Evergreen.V43.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V43.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V43.Api.User.User
    | SetTimeZoneToLocale Time.Zone
