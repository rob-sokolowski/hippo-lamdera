module Evergreen.V22.Gen.Model exposing (..)

import Evergreen.V22.Gen.Params.Cards
import Evergreen.V22.Gen.Params.Catalog
import Evergreen.V22.Gen.Params.Home_
import Evergreen.V22.Gen.Params.Login
import Evergreen.V22.Gen.Params.NotFound
import Evergreen.V22.Gen.Params.Profile.Username_
import Evergreen.V22.Gen.Params.Register
import Evergreen.V22.Gen.Params.Study
import Evergreen.V22.Pages.Cards
import Evergreen.V22.Pages.Catalog
import Evergreen.V22.Pages.Home_
import Evergreen.V22.Pages.Login
import Evergreen.V22.Pages.NotFound
import Evergreen.V22.Pages.Profile.Username_
import Evergreen.V22.Pages.Register
import Evergreen.V22.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V22.Gen.Params.Cards.Params Evergreen.V22.Pages.Cards.Model
    | Catalog Evergreen.V22.Gen.Params.Catalog.Params Evergreen.V22.Pages.Catalog.Model
    | Home_ Evergreen.V22.Gen.Params.Home_.Params Evergreen.V22.Pages.Home_.Model
    | Login Evergreen.V22.Gen.Params.Login.Params Evergreen.V22.Pages.Login.Model
    | NotFound Evergreen.V22.Gen.Params.NotFound.Params Evergreen.V22.Pages.NotFound.Model
    | Register Evergreen.V22.Gen.Params.Register.Params Evergreen.V22.Pages.Register.Model
    | Study Evergreen.V22.Gen.Params.Study.Params Evergreen.V22.Pages.Study.Model
    | Profile__Username_ Evergreen.V22.Gen.Params.Profile.Username_.Params Evergreen.V22.Pages.Profile.Username_.Model
