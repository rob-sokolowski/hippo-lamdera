module Evergreen.V10.Gen.Model exposing (..)

import Evergreen.V10.Gen.Params.Cards
import Evergreen.V10.Gen.Params.Catalog
import Evergreen.V10.Gen.Params.Component_demo_catalog_table
import Evergreen.V10.Gen.Params.Home_
import Evergreen.V10.Gen.Params.Login
import Evergreen.V10.Gen.Params.NotFound
import Evergreen.V10.Gen.Params.Profile.Username_
import Evergreen.V10.Gen.Params.Register
import Evergreen.V10.Gen.Params.Settings
import Evergreen.V10.Gen.Params.Study
import Evergreen.V10.Pages.Cards
import Evergreen.V10.Pages.Catalog
import Evergreen.V10.Pages.Component_demo_catalog_table
import Evergreen.V10.Pages.Home_
import Evergreen.V10.Pages.Login
import Evergreen.V10.Pages.Profile.Username_
import Evergreen.V10.Pages.Register
import Evergreen.V10.Pages.Settings
import Evergreen.V10.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V10.Gen.Params.Cards.Params Evergreen.V10.Pages.Cards.Model
    | Catalog Evergreen.V10.Gen.Params.Catalog.Params Evergreen.V10.Pages.Catalog.Model
    | Component_demo_catalog_table Evergreen.V10.Gen.Params.Component_demo_catalog_table.Params Evergreen.V10.Pages.Component_demo_catalog_table.Model
    | Home_ Evergreen.V10.Gen.Params.Home_.Params Evergreen.V10.Pages.Home_.Model
    | Login Evergreen.V10.Gen.Params.Login.Params Evergreen.V10.Pages.Login.Model
    | NotFound Evergreen.V10.Gen.Params.NotFound.Params
    | Register Evergreen.V10.Gen.Params.Register.Params Evergreen.V10.Pages.Register.Model
    | Settings Evergreen.V10.Gen.Params.Settings.Params Evergreen.V10.Pages.Settings.Model
    | Study Evergreen.V10.Gen.Params.Study.Params Evergreen.V10.Pages.Study.Model
    | Profile__Username_ Evergreen.V10.Gen.Params.Profile.Username_.Params Evergreen.V10.Pages.Profile.Username_.Model