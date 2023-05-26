module Evergreen.V55.Shared exposing (..)

import Evergreen.V55.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V55.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V55.Api.User.User
    | SetTimeZoneToLocale Time.Zone
