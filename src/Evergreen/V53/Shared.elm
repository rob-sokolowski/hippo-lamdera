module Evergreen.V53.Shared exposing (..)

import Evergreen.V53.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V53.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V53.Api.User.User
    | SetTimeZoneToLocale Time.Zone
