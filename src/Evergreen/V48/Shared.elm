module Evergreen.V48.Shared exposing (..)

import Evergreen.V48.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V48.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V48.Api.User.User
    | SetTimeZoneToLocale Time.Zone
