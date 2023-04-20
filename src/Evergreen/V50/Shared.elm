module Evergreen.V50.Shared exposing (..)

import Evergreen.V50.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V50.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V50.Api.User.User
    | SetTimeZoneToLocale Time.Zone
