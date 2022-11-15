module Evergreen.V40.Shared exposing (..)

import Evergreen.V40.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V40.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V40.Api.User.User
    | SetTimeZoneToLocale Time.Zone
