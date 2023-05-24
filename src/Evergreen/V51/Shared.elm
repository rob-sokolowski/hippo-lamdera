module Evergreen.V51.Shared exposing (..)

import Evergreen.V51.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V51.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V51.Api.User.User
    | SetTimeZoneToLocale Time.Zone
