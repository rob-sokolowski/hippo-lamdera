module Evergreen.V26.Gen.Model exposing (..)

import Evergreen.V26.Gen.Params.Cards
import Evergreen.V26.Gen.Params.Catalog
import Evergreen.V26.Gen.Params.Home_
import Evergreen.V26.Gen.Params.Login
import Evergreen.V26.Gen.Params.Login.Provider_.Callback
import Evergreen.V26.Gen.Params.NotFound
import Evergreen.V26.Gen.Params.Study
import Evergreen.V26.Pages.Cards
import Evergreen.V26.Pages.Catalog
import Evergreen.V26.Pages.Home_
import Evergreen.V26.Pages.Login
import Evergreen.V26.Pages.Login.Provider_.Callback
import Evergreen.V26.Pages.NotFound
import Evergreen.V26.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V26.Gen.Params.Cards.Params Evergreen.V26.Pages.Cards.Model
    | Catalog Evergreen.V26.Gen.Params.Catalog.Params Evergreen.V26.Pages.Catalog.Model
    | Home_ Evergreen.V26.Gen.Params.Home_.Params Evergreen.V26.Pages.Home_.Model
    | Login Evergreen.V26.Gen.Params.Login.Params Evergreen.V26.Pages.Login.Model
    | NotFound Evergreen.V26.Gen.Params.NotFound.Params Evergreen.V26.Pages.NotFound.Model
    | Study Evergreen.V26.Gen.Params.Study.Params Evergreen.V26.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V26.Gen.Params.Login.Provider_.Callback.Params Evergreen.V26.Pages.Login.Provider_.Callback.Model
