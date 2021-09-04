module Evergreen.V7.Gen.Msg exposing (..)

import Evergreen.V7.Pages.Cards
import Evergreen.V7.Pages.Home_
import Evergreen.V7.Pages.Login
import Evergreen.V7.Pages.Profile.Username_
import Evergreen.V7.Pages.Register
import Evergreen.V7.Pages.Settings
import Evergreen.V7.Pages.Study


type Msg
    = Cards Evergreen.V7.Pages.Cards.Msg
    | Home_ Evergreen.V7.Pages.Home_.Msg
    | Login Evergreen.V7.Pages.Login.Msg
    | Register Evergreen.V7.Pages.Register.Msg
    | Settings Evergreen.V7.Pages.Settings.Msg
    | Study Evergreen.V7.Pages.Study.Msg
    | Profile__Username_ Evergreen.V7.Pages.Profile.Username_.Msg