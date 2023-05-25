module Evergreen.V52.Shared exposing (..)

import Evergreen.V52.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V52.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V52.Api.User.User
    | SetTimeZoneToLocale Time.Zone
