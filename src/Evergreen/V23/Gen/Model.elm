module Evergreen.V23.Gen.Model exposing (..)

import Evergreen.V23.Gen.Params.Cards
import Evergreen.V23.Gen.Params.Catalog
import Evergreen.V23.Gen.Params.Home_
import Evergreen.V23.Gen.Params.Login
import Evergreen.V23.Gen.Params.NotFound
import Evergreen.V23.Gen.Params.Register
import Evergreen.V23.Gen.Params.Study
import Evergreen.V23.Pages.Cards
import Evergreen.V23.Pages.Catalog
import Evergreen.V23.Pages.Home_
import Evergreen.V23.Pages.Login
import Evergreen.V23.Pages.NotFound
import Evergreen.V23.Pages.Register
import Evergreen.V23.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V23.Gen.Params.Cards.Params Evergreen.V23.Pages.Cards.Model
    | Catalog Evergreen.V23.Gen.Params.Catalog.Params Evergreen.V23.Pages.Catalog.Model
    | Home_ Evergreen.V23.Gen.Params.Home_.Params Evergreen.V23.Pages.Home_.Model
    | Login Evergreen.V23.Gen.Params.Login.Params Evergreen.V23.Pages.Login.Model
    | NotFound Evergreen.V23.Gen.Params.NotFound.Params Evergreen.V23.Pages.NotFound.Model
    | Register Evergreen.V23.Gen.Params.Register.Params Evergreen.V23.Pages.Register.Model
    | Study Evergreen.V23.Gen.Params.Study.Params Evergreen.V23.Pages.Study.Model
