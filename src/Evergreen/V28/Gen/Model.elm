module Evergreen.V28.Gen.Model exposing (..)

import Evergreen.V28.Gen.Params.Cards
import Evergreen.V28.Gen.Params.Catalog
import Evergreen.V28.Gen.Params.Home_
import Evergreen.V28.Gen.Params.Login
import Evergreen.V28.Gen.Params.Login.Provider_.Callback
import Evergreen.V28.Gen.Params.NotFound
import Evergreen.V28.Gen.Params.Study
import Evergreen.V28.Pages.Cards
import Evergreen.V28.Pages.Catalog
import Evergreen.V28.Pages.Home_
import Evergreen.V28.Pages.Login
import Evergreen.V28.Pages.Login.Provider_.Callback
import Evergreen.V28.Pages.NotFound
import Evergreen.V28.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V28.Gen.Params.Cards.Params Evergreen.V28.Pages.Cards.Model
    | Catalog Evergreen.V28.Gen.Params.Catalog.Params Evergreen.V28.Pages.Catalog.Model
    | Home_ Evergreen.V28.Gen.Params.Home_.Params Evergreen.V28.Pages.Home_.Model
    | Login Evergreen.V28.Gen.Params.Login.Params Evergreen.V28.Pages.Login.Model
    | NotFound Evergreen.V28.Gen.Params.NotFound.Params Evergreen.V28.Pages.NotFound.Model
    | Study Evergreen.V28.Gen.Params.Study.Params Evergreen.V28.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V28.Gen.Params.Login.Provider_.Callback.Params Evergreen.V28.Pages.Login.Provider_.Callback.Model
