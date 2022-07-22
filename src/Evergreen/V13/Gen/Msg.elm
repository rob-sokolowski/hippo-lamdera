module Evergreen.V13.Gen.Msg exposing (..)

import Evergreen.V13.Pages.Cards
import Evergreen.V13.Pages.Catalog
import Evergreen.V13.Pages.Component_demo_catalog_table
import Evergreen.V13.Pages.Home_
import Evergreen.V13.Pages.Login
import Evergreen.V13.Pages.NotFound
import Evergreen.V13.Pages.Profile.Username_
import Evergreen.V13.Pages.Register
import Evergreen.V13.Pages.Settings
import Evergreen.V13.Pages.Study


type Msg
    = Cards Evergreen.V13.Pages.Cards.Msg
    | Catalog Evergreen.V13.Pages.Catalog.Msg
    | Component_demo_catalog_table Evergreen.V13.Pages.Component_demo_catalog_table.Msg
    | Home_ Evergreen.V13.Pages.Home_.Msg
    | Login Evergreen.V13.Pages.Login.Msg
    | NotFound Evergreen.V13.Pages.NotFound.Msg
    | Register Evergreen.V13.Pages.Register.Msg
    | Settings Evergreen.V13.Pages.Settings.Msg
    | Study Evergreen.V13.Pages.Study.Msg
    | Profile__Username_ Evergreen.V13.Pages.Profile.Username_.Msg