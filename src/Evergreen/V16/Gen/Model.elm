module Evergreen.V16.Gen.Model exposing (..)

import Evergreen.V16.Gen.Params.Cards
import Evergreen.V16.Gen.Params.Catalog
import Evergreen.V16.Gen.Params.Home_
import Evergreen.V16.Gen.Params.Login
import Evergreen.V16.Gen.Params.NotFound
import Evergreen.V16.Gen.Params.Profile.Username_
import Evergreen.V16.Gen.Params.Register
import Evergreen.V16.Gen.Params.Settings
import Evergreen.V16.Gen.Params.Study
import Evergreen.V16.Pages.Cards
import Evergreen.V16.Pages.Catalog
import Evergreen.V16.Pages.Home_
import Evergreen.V16.Pages.Login
import Evergreen.V16.Pages.NotFound
import Evergreen.V16.Pages.Profile.Username_
import Evergreen.V16.Pages.Register
import Evergreen.V16.Pages.Settings
import Evergreen.V16.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V16.Gen.Params.Cards.Params Evergreen.V16.Pages.Cards.Model
    | Catalog Evergreen.V16.Gen.Params.Catalog.Params Evergreen.V16.Pages.Catalog.Model
    | Home_ Evergreen.V16.Gen.Params.Home_.Params Evergreen.V16.Pages.Home_.Model
    | Login Evergreen.V16.Gen.Params.Login.Params Evergreen.V16.Pages.Login.Model
    | NotFound Evergreen.V16.Gen.Params.NotFound.Params Evergreen.V16.Pages.NotFound.Model
    | Register Evergreen.V16.Gen.Params.Register.Params Evergreen.V16.Pages.Register.Model
    | Settings Evergreen.V16.Gen.Params.Settings.Params Evergreen.V16.Pages.Settings.Model
    | Study Evergreen.V16.Gen.Params.Study.Params Evergreen.V16.Pages.Study.Model
    | Profile__Username_ Evergreen.V16.Gen.Params.Profile.Username_.Params Evergreen.V16.Pages.Profile.Username_.Model
