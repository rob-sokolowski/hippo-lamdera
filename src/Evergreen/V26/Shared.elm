module Evergreen.V26.Shared exposing (..)

import Evergreen.V26.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V26.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V26.Api.User.User
    | SetTimeZoneToLocale Time.Zone
