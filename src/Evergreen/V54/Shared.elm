module Evergreen.V54.Shared exposing (..)

import Evergreen.V54.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V54.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V54.Api.User.User
    | SetTimeZoneToLocale Time.Zone
