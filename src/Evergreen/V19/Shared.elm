module Evergreen.V19.Shared exposing (..)

import Evergreen.V19.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V19.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V19.Api.User.User
    | SetTimeZoneToLocale Time.Zone
