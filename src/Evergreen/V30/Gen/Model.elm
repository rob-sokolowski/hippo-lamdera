module Evergreen.V30.Gen.Model exposing (..)

import Evergreen.V30.Gen.Params.Cards
import Evergreen.V30.Gen.Params.Catalog
import Evergreen.V30.Gen.Params.Home_
import Evergreen.V30.Gen.Params.Login
import Evergreen.V30.Gen.Params.Login.Provider_.Callback
import Evergreen.V30.Gen.Params.NotFound
import Evergreen.V30.Gen.Params.Study
import Evergreen.V30.Pages.Cards
import Evergreen.V30.Pages.Catalog
import Evergreen.V30.Pages.Home_
import Evergreen.V30.Pages.Login
import Evergreen.V30.Pages.Login.Provider_.Callback
import Evergreen.V30.Pages.NotFound
import Evergreen.V30.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V30.Gen.Params.Cards.Params Evergreen.V30.Pages.Cards.Model
    | Catalog Evergreen.V30.Gen.Params.Catalog.Params Evergreen.V30.Pages.Catalog.Model
    | Home_ Evergreen.V30.Gen.Params.Home_.Params Evergreen.V30.Pages.Home_.Model
    | Login Evergreen.V30.Gen.Params.Login.Params Evergreen.V30.Pages.Login.Model
    | NotFound Evergreen.V30.Gen.Params.NotFound.Params Evergreen.V30.Pages.NotFound.Model
    | Study Evergreen.V30.Gen.Params.Study.Params Evergreen.V30.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V30.Gen.Params.Login.Provider_.Callback.Params Evergreen.V30.Pages.Login.Provider_.Callback.Model
