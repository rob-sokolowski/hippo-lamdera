module Evergreen.V21.Shared exposing (..)

import Evergreen.V21.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V21.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V21.Api.User.User
    | SetTimeZoneToLocale Time.Zone
