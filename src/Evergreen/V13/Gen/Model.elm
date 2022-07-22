module Evergreen.V13.Gen.Model exposing (..)

import Evergreen.V13.Gen.Params.Cards
import Evergreen.V13.Gen.Params.Catalog
import Evergreen.V13.Gen.Params.Component_demo_catalog_table
import Evergreen.V13.Gen.Params.Home_
import Evergreen.V13.Gen.Params.Login
import Evergreen.V13.Gen.Params.NotFound
import Evergreen.V13.Gen.Params.Profile.Username_
import Evergreen.V13.Gen.Params.Register
import Evergreen.V13.Gen.Params.Settings
import Evergreen.V13.Gen.Params.Study
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


type Model
    = Redirecting_
    | Cards Evergreen.V13.Gen.Params.Cards.Params Evergreen.V13.Pages.Cards.Model
    | Catalog Evergreen.V13.Gen.Params.Catalog.Params Evergreen.V13.Pages.Catalog.Model
    | Component_demo_catalog_table Evergreen.V13.Gen.Params.Component_demo_catalog_table.Params Evergreen.V13.Pages.Component_demo_catalog_table.Model
    | Home_ Evergreen.V13.Gen.Params.Home_.Params Evergreen.V13.Pages.Home_.Model
    | Login Evergreen.V13.Gen.Params.Login.Params Evergreen.V13.Pages.Login.Model
    | NotFound Evergreen.V13.Gen.Params.NotFound.Params Evergreen.V13.Pages.NotFound.Model
    | Register Evergreen.V13.Gen.Params.Register.Params Evergreen.V13.Pages.Register.Model
    | Settings Evergreen.V13.Gen.Params.Settings.Params Evergreen.V13.Pages.Settings.Model
    | Study Evergreen.V13.Gen.Params.Study.Params Evergreen.V13.Pages.Study.Model
    | Profile__Username_ Evergreen.V13.Gen.Params.Profile.Username_.Params Evergreen.V13.Pages.Profile.Username_.Model