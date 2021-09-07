module Evergreen.V10.Gen.Msg exposing (..)

import Evergreen.V10.Pages.Cards
import Evergreen.V10.Pages.Catalog
import Evergreen.V10.Pages.Component_demo_catalog_table
import Evergreen.V10.Pages.Home_
import Evergreen.V10.Pages.Login
import Evergreen.V10.Pages.Profile.Username_
import Evergreen.V10.Pages.Register
import Evergreen.V10.Pages.Settings
import Evergreen.V10.Pages.Study


type Msg
    = Cards Evergreen.V10.Pages.Cards.Msg
    | Catalog Evergreen.V10.Pages.Catalog.Msg
    | Component_demo_catalog_table Evergreen.V10.Pages.Component_demo_catalog_table.Msg
    | Home_ Evergreen.V10.Pages.Home_.Msg
    | Login Evergreen.V10.Pages.Login.Msg
    | Register Evergreen.V10.Pages.Register.Msg
    | Settings Evergreen.V10.Pages.Settings.Msg
    | Study Evergreen.V10.Pages.Study.Msg
    | Profile__Username_ Evergreen.V10.Pages.Profile.Username_.Msg