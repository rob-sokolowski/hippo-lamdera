module Evergreen.V39.Gen.Model exposing (..)

import Evergreen.V39.Gen.Params.Admin
import Evergreen.V39.Gen.Params.Cards
import Evergreen.V39.Gen.Params.Catalog
import Evergreen.V39.Gen.Params.Home_
import Evergreen.V39.Gen.Params.Login
import Evergreen.V39.Gen.Params.Login.Provider_.Callback
import Evergreen.V39.Gen.Params.NotFound
import Evergreen.V39.Gen.Params.Study
import Evergreen.V39.Pages.Admin
import Evergreen.V39.Pages.Cards
import Evergreen.V39.Pages.Catalog
import Evergreen.V39.Pages.Home_
import Evergreen.V39.Pages.Login
import Evergreen.V39.Pages.Login.Provider_.Callback
import Evergreen.V39.Pages.NotFound
import Evergreen.V39.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V39.Gen.Params.Admin.Params Evergreen.V39.Pages.Admin.Model
    | Cards Evergreen.V39.Gen.Params.Cards.Params Evergreen.V39.Pages.Cards.Model
    | Catalog Evergreen.V39.Gen.Params.Catalog.Params Evergreen.V39.Pages.Catalog.Model
    | Home_ Evergreen.V39.Gen.Params.Home_.Params Evergreen.V39.Pages.Home_.Model
    | Login Evergreen.V39.Gen.Params.Login.Params Evergreen.V39.Pages.Login.Model
    | NotFound Evergreen.V39.Gen.Params.NotFound.Params Evergreen.V39.Pages.NotFound.Model
    | Study Evergreen.V39.Gen.Params.Study.Params Evergreen.V39.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V39.Gen.Params.Login.Provider_.Callback.Params Evergreen.V39.Pages.Login.Provider_.Callback.Model
