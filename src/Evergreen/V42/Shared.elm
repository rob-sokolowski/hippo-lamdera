module Evergreen.V42.Shared exposing (..)

import Evergreen.V42.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V42.Api.User.User
    , zone : Time.Zone
    }


type Msg
    = ClickedSignOut
    | SignedInUser Evergreen.V42.Api.User.User
    | SetTimeZoneToLocale Time.Zone
