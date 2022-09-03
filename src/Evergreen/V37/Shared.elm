module Evergreen.V37.Shared exposing (..)

import Evergreen.V37.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V37.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V37.Api.User.User
    | SetTimeZoneToLocale Time.Zone
