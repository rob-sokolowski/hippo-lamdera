module Evergreen.V33.Gen.Model exposing (..)

import Evergreen.V33.Gen.Params.Cards
import Evergreen.V33.Gen.Params.Catalog
import Evergreen.V33.Gen.Params.Home_
import Evergreen.V33.Gen.Params.Login
import Evergreen.V33.Gen.Params.Login.Provider_.Callback
import Evergreen.V33.Gen.Params.NotFound
import Evergreen.V33.Gen.Params.Study
import Evergreen.V33.Pages.Cards
import Evergreen.V33.Pages.Catalog
import Evergreen.V33.Pages.Home_
import Evergreen.V33.Pages.Login
import Evergreen.V33.Pages.Login.Provider_.Callback
import Evergreen.V33.Pages.NotFound
import Evergreen.V33.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V33.Gen.Params.Cards.Params Evergreen.V33.Pages.Cards.Model
    | Catalog Evergreen.V33.Gen.Params.Catalog.Params Evergreen.V33.Pages.Catalog.Model
    | Home_ Evergreen.V33.Gen.Params.Home_.Params Evergreen.V33.Pages.Home_.Model
    | Login Evergreen.V33.Gen.Params.Login.Params Evergreen.V33.Pages.Login.Model
    | NotFound Evergreen.V33.Gen.Params.NotFound.Params Evergreen.V33.Pages.NotFound.Model
    | Study Evergreen.V33.Gen.Params.Study.Params Evergreen.V33.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V33.Gen.Params.Login.Provider_.Callback.Params Evergreen.V33.Pages.Login.Provider_.Callback.Model
