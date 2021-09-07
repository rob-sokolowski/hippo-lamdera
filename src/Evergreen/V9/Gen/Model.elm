module Evergreen.V9.Gen.Model exposing (..)

import Evergreen.V9.Gen.Params.Cards
import Evergreen.V9.Gen.Params.Catalog
import Evergreen.V9.Gen.Params.Component_demo_catalog_table
import Evergreen.V9.Gen.Params.Home_
import Evergreen.V9.Gen.Params.Login
import Evergreen.V9.Gen.Params.NotFound
import Evergreen.V9.Gen.Params.Profile.Username_
import Evergreen.V9.Gen.Params.Register
import Evergreen.V9.Gen.Params.Settings
import Evergreen.V9.Gen.Params.Study
import Evergreen.V9.Pages.Cards
import Evergreen.V9.Pages.Catalog
import Evergreen.V9.Pages.Component_demo_catalog_table
import Evergreen.V9.Pages.Home_
import Evergreen.V9.Pages.Login
import Evergreen.V9.Pages.Profile.Username_
import Evergreen.V9.Pages.Register
import Evergreen.V9.Pages.Settings
import Evergreen.V9.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V9.Gen.Params.Cards.Params Evergreen.V9.Pages.Cards.Model
    | Catalog Evergreen.V9.Gen.Params.Catalog.Params Evergreen.V9.Pages.Catalog.Model
    | Component_demo_catalog_table Evergreen.V9.Gen.Params.Component_demo_catalog_table.Params Evergreen.V9.Pages.Component_demo_catalog_table.Model
    | Home_ Evergreen.V9.Gen.Params.Home_.Params Evergreen.V9.Pages.Home_.Model
    | Login Evergreen.V9.Gen.Params.Login.Params Evergreen.V9.Pages.Login.Model
    | NotFound Evergreen.V9.Gen.Params.NotFound.Params
    | Register Evergreen.V9.Gen.Params.Register.Params Evergreen.V9.Pages.Register.Model
    | Settings Evergreen.V9.Gen.Params.Settings.Params Evergreen.V9.Pages.Settings.Model
    | Study Evergreen.V9.Gen.Params.Study.Params Evergreen.V9.Pages.Study.Model
    | Profile__Username_ Evergreen.V9.Gen.Params.Profile.Username_.Params Evergreen.V9.Pages.Profile.Username_.Model