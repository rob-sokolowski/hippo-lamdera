module Evergreen.V6.Gen.Msg exposing (..)

import Evergreen.V6.Pages.Cards
import Evergreen.V6.Pages.Home_
import Evergreen.V6.Pages.Login
import Evergreen.V6.Pages.Profile.Username_
import Evergreen.V6.Pages.Register
import Evergreen.V6.Pages.Settings
import Evergreen.V6.Pages.Study


type Msg
    = Cards Evergreen.V6.Pages.Cards.Msg
    | Home_ Evergreen.V6.Pages.Home_.Msg
    | Login Evergreen.V6.Pages.Login.Msg
    | Register Evergreen.V6.Pages.Register.Msg
    | Settings Evergreen.V6.Pages.Settings.Msg
    | Study Evergreen.V6.Pages.Study.Msg
    | Profile__Username_ Evergreen.V6.Pages.Profile.Username_.Msg