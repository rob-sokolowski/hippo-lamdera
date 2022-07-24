module Evergreen.V19.Gen.Msg exposing (..)

import Evergreen.V19.Pages.Cards
import Evergreen.V19.Pages.Catalog
import Evergreen.V19.Pages.Home_
import Evergreen.V19.Pages.Login
import Evergreen.V19.Pages.NotFound
import Evergreen.V19.Pages.Profile.Username_
import Evergreen.V19.Pages.Register
import Evergreen.V19.Pages.Settings
import Evergreen.V19.Pages.Study


type Msg
    = Cards Evergreen.V19.Pages.Cards.Msg
    | Catalog Evergreen.V19.Pages.Catalog.Msg
    | Home_ Evergreen.V19.Pages.Home_.Msg
    | Login Evergreen.V19.Pages.Login.Msg
    | NotFound Evergreen.V19.Pages.NotFound.Msg
    | Register Evergreen.V19.Pages.Register.Msg
    | Settings Evergreen.V19.Pages.Settings.Msg
    | Study Evergreen.V19.Pages.Study.Msg
    | Profile__Username_ Evergreen.V19.Pages.Profile.Username_.Msg
