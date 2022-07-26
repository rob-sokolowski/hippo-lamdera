module Evergreen.V25.Gen.Model exposing (..)

import Evergreen.V25.Gen.Params.Cards
import Evergreen.V25.Gen.Params.Catalog
import Evergreen.V25.Gen.Params.Home_
import Evergreen.V25.Gen.Params.Login
import Evergreen.V25.Gen.Params.Login.Provider_.Callback
import Evergreen.V25.Gen.Params.NotFound
import Evergreen.V25.Gen.Params.Study
import Evergreen.V25.Pages.Cards
import Evergreen.V25.Pages.Catalog
import Evergreen.V25.Pages.Home_
import Evergreen.V25.Pages.Login
import Evergreen.V25.Pages.Login.Provider_.Callback
import Evergreen.V25.Pages.NotFound
import Evergreen.V25.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V25.Gen.Params.Cards.Params Evergreen.V25.Pages.Cards.Model
    | Catalog Evergreen.V25.Gen.Params.Catalog.Params Evergreen.V25.Pages.Catalog.Model
    | Home_ Evergreen.V25.Gen.Params.Home_.Params Evergreen.V25.Pages.Home_.Model
    | Login Evergreen.V25.Gen.Params.Login.Params Evergreen.V25.Pages.Login.Model
    | NotFound Evergreen.V25.Gen.Params.NotFound.Params Evergreen.V25.Pages.NotFound.Model
    | Study Evergreen.V25.Gen.Params.Study.Params Evergreen.V25.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V25.Gen.Params.Login.Provider_.Callback.Params Evergreen.V25.Pages.Login.Provider_.Callback.Model
