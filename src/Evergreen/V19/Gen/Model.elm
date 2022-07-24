module Evergreen.V19.Gen.Model exposing (..)

import Evergreen.V19.Gen.Params.Cards
import Evergreen.V19.Gen.Params.Catalog
import Evergreen.V19.Gen.Params.Home_
import Evergreen.V19.Gen.Params.Login
import Evergreen.V19.Gen.Params.NotFound
import Evergreen.V19.Gen.Params.Profile.Username_
import Evergreen.V19.Gen.Params.Register
import Evergreen.V19.Gen.Params.Settings
import Evergreen.V19.Gen.Params.Study
import Evergreen.V19.Pages.Cards
import Evergreen.V19.Pages.Catalog
import Evergreen.V19.Pages.Home_
import Evergreen.V19.Pages.Login
import Evergreen.V19.Pages.NotFound
import Evergreen.V19.Pages.Profile.Username_
import Evergreen.V19.Pages.Register
import Evergreen.V19.Pages.Settings
import Evergreen.V19.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V19.Gen.Params.Cards.Params Evergreen.V19.Pages.Cards.Model
    | Catalog Evergreen.V19.Gen.Params.Catalog.Params Evergreen.V19.Pages.Catalog.Model
    | Home_ Evergreen.V19.Gen.Params.Home_.Params Evergreen.V19.Pages.Home_.Model
    | Login Evergreen.V19.Gen.Params.Login.Params Evergreen.V19.Pages.Login.Model
    | NotFound Evergreen.V19.Gen.Params.NotFound.Params Evergreen.V19.Pages.NotFound.Model
    | Register Evergreen.V19.Gen.Params.Register.Params Evergreen.V19.Pages.Register.Model
    | Settings Evergreen.V19.Gen.Params.Settings.Params Evergreen.V19.Pages.Settings.Model
    | Study Evergreen.V19.Gen.Params.Study.Params Evergreen.V19.Pages.Study.Model
    | Profile__Username_ Evergreen.V19.Gen.Params.Profile.Username_.Params Evergreen.V19.Pages.Profile.Username_.Model
