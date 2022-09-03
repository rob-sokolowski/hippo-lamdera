module Evergreen.V33.Shared exposing (..)

import Evergreen.V33.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V33.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V33.Api.User.User
    | SetTimeZoneToLocale Time.Zone
