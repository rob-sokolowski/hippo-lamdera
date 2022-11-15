module Evergreen.V40.Gen.Model exposing (..)

import Evergreen.V40.Gen.Params.Admin
import Evergreen.V40.Gen.Params.Cards
import Evergreen.V40.Gen.Params.Catalog
import Evergreen.V40.Gen.Params.Home_
import Evergreen.V40.Gen.Params.Login
import Evergreen.V40.Gen.Params.Login.Provider_.Callback
import Evergreen.V40.Gen.Params.NotFound
import Evergreen.V40.Gen.Params.Study
import Evergreen.V40.Pages.Admin
import Evergreen.V40.Pages.Cards
import Evergreen.V40.Pages.Catalog
import Evergreen.V40.Pages.Home_
import Evergreen.V40.Pages.Login
import Evergreen.V40.Pages.Login.Provider_.Callback
import Evergreen.V40.Pages.NotFound
import Evergreen.V40.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V40.Gen.Params.Admin.Params Evergreen.V40.Pages.Admin.Model
    | Cards Evergreen.V40.Gen.Params.Cards.Params Evergreen.V40.Pages.Cards.Model
    | Catalog Evergreen.V40.Gen.Params.Catalog.Params Evergreen.V40.Pages.Catalog.Model
    | Home_ Evergreen.V40.Gen.Params.Home_.Params Evergreen.V40.Pages.Home_.Model
    | Login Evergreen.V40.Gen.Params.Login.Params Evergreen.V40.Pages.Login.Model
    | NotFound Evergreen.V40.Gen.Params.NotFound.Params Evergreen.V40.Pages.NotFound.Model
    | Study Evergreen.V40.Gen.Params.Study.Params Evergreen.V40.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V40.Gen.Params.Login.Provider_.Callback.Params Evergreen.V40.Pages.Login.Provider_.Callback.Model
