module Evergreen.V5.Gen.Msg exposing (..)

import Evergreen.V5.Pages.Cards
import Evergreen.V5.Pages.Home_
import Evergreen.V5.Pages.Login
import Evergreen.V5.Pages.Profile.Username_
import Evergreen.V5.Pages.Register
import Evergreen.V5.Pages.Settings
import Evergreen.V5.Pages.Study


type Msg
    = Cards Evergreen.V5.Pages.Cards.Msg
    | Home_ Evergreen.V5.Pages.Home_.Msg
    | Login Evergreen.V5.Pages.Login.Msg
    | Register Evergreen.V5.Pages.Register.Msg
    | Settings Evergreen.V5.Pages.Settings.Msg
    | Study Evergreen.V5.Pages.Study.Msg
    | Profile__Username_ Evergreen.V5.Pages.Profile.Username_.Msg