module Evergreen.V16.Shared exposing (..)

import Evergreen.V16.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V16.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V16.Api.User.User
    | SetTimeZoneToLocale Time.Zone
