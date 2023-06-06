module Evergreen.V56.Shared exposing (..)

import Evergreen.V56.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V56.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V56.Api.User.User
    | SetTimeZoneToLocale Time.Zone
