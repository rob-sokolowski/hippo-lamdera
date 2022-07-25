module Evergreen.V21.Gen.Model exposing (..)

import Evergreen.V21.Gen.Params.Cards
import Evergreen.V21.Gen.Params.Catalog
import Evergreen.V21.Gen.Params.Home_
import Evergreen.V21.Gen.Params.Login
import Evergreen.V21.Gen.Params.NotFound
import Evergreen.V21.Gen.Params.Profile.Username_
import Evergreen.V21.Gen.Params.Register
import Evergreen.V21.Gen.Params.Settings
import Evergreen.V21.Gen.Params.Study
import Evergreen.V21.Pages.Cards
import Evergreen.V21.Pages.Catalog
import Evergreen.V21.Pages.Home_
import Evergreen.V21.Pages.Login
import Evergreen.V21.Pages.NotFound
import Evergreen.V21.Pages.Profile.Username_
import Evergreen.V21.Pages.Register
import Evergreen.V21.Pages.Settings
import Evergreen.V21.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V21.Gen.Params.Cards.Params Evergreen.V21.Pages.Cards.Model
    | Catalog Evergreen.V21.Gen.Params.Catalog.Params Evergreen.V21.Pages.Catalog.Model
    | Home_ Evergreen.V21.Gen.Params.Home_.Params Evergreen.V21.Pages.Home_.Model
    | Login Evergreen.V21.Gen.Params.Login.Params Evergreen.V21.Pages.Login.Model
    | NotFound Evergreen.V21.Gen.Params.NotFound.Params Evergreen.V21.Pages.NotFound.Model
    | Register Evergreen.V21.Gen.Params.Register.Params Evergreen.V21.Pages.Register.Model
    | Settings Evergreen.V21.Gen.Params.Settings.Params Evergreen.V21.Pages.Settings.Model
    | Study Evergreen.V21.Gen.Params.Study.Params Evergreen.V21.Pages.Study.Model
    | Profile__Username_ Evergreen.V21.Gen.Params.Profile.Username_.Params Evergreen.V21.Pages.Profile.Username_.Model
