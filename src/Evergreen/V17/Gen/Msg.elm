module Evergreen.V17.Gen.Msg exposing (..)

import Evergreen.V17.Pages.Cards
import Evergreen.V17.Pages.Catalog
import Evergreen.V17.Pages.Home_
import Evergreen.V17.Pages.Login
import Evergreen.V17.Pages.NotFound
import Evergreen.V17.Pages.Profile.Username_
import Evergreen.V17.Pages.Register
import Evergreen.V17.Pages.Settings
import Evergreen.V17.Pages.Study


type Msg
    = Cards Evergreen.V17.Pages.Cards.Msg
    | Catalog Evergreen.V17.Pages.Catalog.Msg
    | Home_ Evergreen.V17.Pages.Home_.Msg
    | Login Evergreen.V17.Pages.Login.Msg
    | NotFound Evergreen.V17.Pages.NotFound.Msg
    | Register Evergreen.V17.Pages.Register.Msg
    | Settings Evergreen.V17.Pages.Settings.Msg
    | Study Evergreen.V17.Pages.Study.Msg
    | Profile__Username_ Evergreen.V17.Pages.Profile.Username_.Msg
