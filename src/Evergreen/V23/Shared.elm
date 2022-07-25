module Evergreen.V23.Shared exposing (..)

import Evergreen.V23.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V23.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V23.Api.User.User
    | SetTimeZoneToLocale Time.Zone
