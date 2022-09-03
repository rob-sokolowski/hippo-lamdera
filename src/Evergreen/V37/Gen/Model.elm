module Evergreen.V37.Gen.Model exposing (..)

import Evergreen.V37.Gen.Params.Admin
import Evergreen.V37.Gen.Params.Cards
import Evergreen.V37.Gen.Params.Catalog
import Evergreen.V37.Gen.Params.Home_
import Evergreen.V37.Gen.Params.Login
import Evergreen.V37.Gen.Params.Login.Provider_.Callback
import Evergreen.V37.Gen.Params.NotFound
import Evergreen.V37.Gen.Params.Study
import Evergreen.V37.Pages.Admin
import Evergreen.V37.Pages.Cards
import Evergreen.V37.Pages.Catalog
import Evergreen.V37.Pages.Home_
import Evergreen.V37.Pages.Login
import Evergreen.V37.Pages.Login.Provider_.Callback
import Evergreen.V37.Pages.NotFound
import Evergreen.V37.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V37.Gen.Params.Admin.Params Evergreen.V37.Pages.Admin.Model
    | Cards Evergreen.V37.Gen.Params.Cards.Params Evergreen.V37.Pages.Cards.Model
    | Catalog Evergreen.V37.Gen.Params.Catalog.Params Evergreen.V37.Pages.Catalog.Model
    | Home_ Evergreen.V37.Gen.Params.Home_.Params Evergreen.V37.Pages.Home_.Model
    | Login Evergreen.V37.Gen.Params.Login.Params Evergreen.V37.Pages.Login.Model
    | NotFound Evergreen.V37.Gen.Params.NotFound.Params Evergreen.V37.Pages.NotFound.Model
    | Study Evergreen.V37.Gen.Params.Study.Params Evergreen.V37.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V37.Gen.Params.Login.Provider_.Callback.Params Evergreen.V37.Pages.Login.Provider_.Callback.Model
