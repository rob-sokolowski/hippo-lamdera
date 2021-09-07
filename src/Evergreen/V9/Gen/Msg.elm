module Evergreen.V9.Gen.Msg exposing (..)

import Evergreen.V9.Pages.Cards
import Evergreen.V9.Pages.Catalog
import Evergreen.V9.Pages.Component_demo_catalog_table
import Evergreen.V9.Pages.Home_
import Evergreen.V9.Pages.Login
import Evergreen.V9.Pages.Profile.Username_
import Evergreen.V9.Pages.Register
import Evergreen.V9.Pages.Settings
import Evergreen.V9.Pages.Study


type Msg
    = Cards Evergreen.V9.Pages.Cards.Msg
    | Catalog Evergreen.V9.Pages.Catalog.Msg
    | Component_demo_catalog_table Evergreen.V9.Pages.Component_demo_catalog_table.Msg
    | Home_ Evergreen.V9.Pages.Home_.Msg
    | Login Evergreen.V9.Pages.Login.Msg
    | Register Evergreen.V9.Pages.Register.Msg
    | Settings Evergreen.V9.Pages.Settings.Msg
    | Study Evergreen.V9.Pages.Study.Msg
    | Profile__Username_ Evergreen.V9.Pages.Profile.Username_.Msg