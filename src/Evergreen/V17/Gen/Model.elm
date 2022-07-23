module Evergreen.V17.Gen.Model exposing (..)

import Evergreen.V17.Gen.Params.Cards
import Evergreen.V17.Gen.Params.Catalog
import Evergreen.V17.Gen.Params.Home_
import Evergreen.V17.Gen.Params.Login
import Evergreen.V17.Gen.Params.NotFound
import Evergreen.V17.Gen.Params.Profile.Username_
import Evergreen.V17.Gen.Params.Register
import Evergreen.V17.Gen.Params.Settings
import Evergreen.V17.Gen.Params.Study
import Evergreen.V17.Pages.Cards
import Evergreen.V17.Pages.Catalog
import Evergreen.V17.Pages.Home_
import Evergreen.V17.Pages.Login
import Evergreen.V17.Pages.NotFound
import Evergreen.V17.Pages.Profile.Username_
import Evergreen.V17.Pages.Register
import Evergreen.V17.Pages.Settings
import Evergreen.V17.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V17.Gen.Params.Cards.Params Evergreen.V17.Pages.Cards.Model
    | Catalog Evergreen.V17.Gen.Params.Catalog.Params Evergreen.V17.Pages.Catalog.Model
    | Home_ Evergreen.V17.Gen.Params.Home_.Params Evergreen.V17.Pages.Home_.Model
    | Login Evergreen.V17.Gen.Params.Login.Params Evergreen.V17.Pages.Login.Model
    | NotFound Evergreen.V17.Gen.Params.NotFound.Params Evergreen.V17.Pages.NotFound.Model
    | Register Evergreen.V17.Gen.Params.Register.Params Evergreen.V17.Pages.Register.Model
    | Settings Evergreen.V17.Gen.Params.Settings.Params Evergreen.V17.Pages.Settings.Model
    | Study Evergreen.V17.Gen.Params.Study.Params Evergreen.V17.Pages.Study.Model
    | Profile__Username_ Evergreen.V17.Gen.Params.Profile.Username_.Params Evergreen.V17.Pages.Profile.Username_.Model
