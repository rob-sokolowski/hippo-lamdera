module Evergreen.V21.Gen.Msg exposing (..)

import Evergreen.V21.Pages.Cards
import Evergreen.V21.Pages.Catalog
import Evergreen.V21.Pages.Home_
import Evergreen.V21.Pages.Login
import Evergreen.V21.Pages.NotFound
import Evergreen.V21.Pages.Profile.Username_
import Evergreen.V21.Pages.Register
import Evergreen.V21.Pages.Settings
import Evergreen.V21.Pages.Study


type Msg
    = Cards Evergreen.V21.Pages.Cards.Msg
    | Catalog Evergreen.V21.Pages.Catalog.Msg
    | Home_ Evergreen.V21.Pages.Home_.Msg
    | Login Evergreen.V21.Pages.Login.Msg
    | NotFound Evergreen.V21.Pages.NotFound.Msg
    | Register Evergreen.V21.Pages.Register.Msg
    | Settings Evergreen.V21.Pages.Settings.Msg
    | Study Evergreen.V21.Pages.Study.Msg
    | Profile__Username_ Evergreen.V21.Pages.Profile.Username_.Msg
