module Evergreen.V16.Gen.Msg exposing (..)

import Evergreen.V16.Pages.Cards
import Evergreen.V16.Pages.Catalog
import Evergreen.V16.Pages.Home_
import Evergreen.V16.Pages.Login
import Evergreen.V16.Pages.NotFound
import Evergreen.V16.Pages.Profile.Username_
import Evergreen.V16.Pages.Register
import Evergreen.V16.Pages.Settings
import Evergreen.V16.Pages.Study


type Msg
    = Cards Evergreen.V16.Pages.Cards.Msg
    | Catalog Evergreen.V16.Pages.Catalog.Msg
    | Home_ Evergreen.V16.Pages.Home_.Msg
    | Login Evergreen.V16.Pages.Login.Msg
    | NotFound Evergreen.V16.Pages.NotFound.Msg
    | Register Evergreen.V16.Pages.Register.Msg
    | Settings Evergreen.V16.Pages.Settings.Msg
    | Study Evergreen.V16.Pages.Study.Msg
    | Profile__Username_ Evergreen.V16.Pages.Profile.Username_.Msg
