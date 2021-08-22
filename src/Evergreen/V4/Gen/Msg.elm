module Evergreen.V4.Gen.Msg exposing (..)

import Evergreen.V4.Pages.Cards
import Evergreen.V4.Pages.Home_
import Evergreen.V4.Pages.Login
import Evergreen.V4.Pages.Profile.Username_
import Evergreen.V4.Pages.Register
import Evergreen.V4.Pages.Settings


type Msg
    = Cards Evergreen.V4.Pages.Cards.Msg
    | Home_ Evergreen.V4.Pages.Home_.Msg
    | Login Evergreen.V4.Pages.Login.Msg
    | Register Evergreen.V4.Pages.Register.Msg
    | Settings Evergreen.V4.Pages.Settings.Msg
    | Profile__Username_ Evergreen.V4.Pages.Profile.Username_.Msg
