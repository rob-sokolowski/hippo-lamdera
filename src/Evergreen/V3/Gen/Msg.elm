module Evergreen.V3.Gen.Msg exposing (..)

import Evergreen.V3.Pages.Home_
import Evergreen.V3.Pages.Login
import Evergreen.V3.Pages.Profile.Username_
import Evergreen.V3.Pages.Register
import Evergreen.V3.Pages.Settings


type Msg
    = Home_ Evergreen.V3.Pages.Home_.Msg
    | Login Evergreen.V3.Pages.Login.Msg
    | Register Evergreen.V3.Pages.Register.Msg
    | Settings Evergreen.V3.Pages.Settings.Msg
    | Profile__Username_ Evergreen.V3.Pages.Profile.Username_.Msg
