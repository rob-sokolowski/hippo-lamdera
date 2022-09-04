module Evergreen.V39.Shared exposing (..)

import Evergreen.V39.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V39.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V39.Api.User.User
    | SetTimeZoneToLocale Time.Zone
