module Evergreen.V28.Shared exposing (..)

import Evergreen.V28.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V28.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V28.Api.User.User
    | SetTimeZoneToLocale Time.Zone
