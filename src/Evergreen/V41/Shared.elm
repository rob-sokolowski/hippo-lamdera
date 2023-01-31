module Evergreen.V41.Shared exposing (..)

import Evergreen.V41.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V41.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V41.Api.User.User
    | SetTimeZoneToLocale Time.Zone
