module Evergreen.V43.Gen.Model exposing (..)

import Evergreen.V43.Gen.Params.Admin
import Evergreen.V43.Gen.Params.Cards
import Evergreen.V43.Gen.Params.Catalog
import Evergreen.V43.Gen.Params.Home_
import Evergreen.V43.Gen.Params.Login
import Evergreen.V43.Gen.Params.Login.Provider_.Callback
import Evergreen.V43.Gen.Params.NotFound
import Evergreen.V43.Gen.Params.Stories.KatexDemo
import Evergreen.V43.Gen.Params.Study
import Evergreen.V43.Pages.Admin
import Evergreen.V43.Pages.Cards
import Evergreen.V43.Pages.Catalog
import Evergreen.V43.Pages.Home_
import Evergreen.V43.Pages.Login
import Evergreen.V43.Pages.Login.Provider_.Callback
import Evergreen.V43.Pages.NotFound
import Evergreen.V43.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V43.Gen.Params.Admin.Params Evergreen.V43.Pages.Admin.Model
    | Cards Evergreen.V43.Gen.Params.Cards.Params Evergreen.V43.Pages.Cards.Model
    | Catalog Evergreen.V43.Gen.Params.Catalog.Params Evergreen.V43.Pages.Catalog.Model
    | Home_ Evergreen.V43.Gen.Params.Home_.Params Evergreen.V43.Pages.Home_.Model
    | Login Evergreen.V43.Gen.Params.Login.Params Evergreen.V43.Pages.Login.Model
    | NotFound Evergreen.V43.Gen.Params.NotFound.Params Evergreen.V43.Pages.NotFound.Model
    | Study Evergreen.V43.Gen.Params.Study.Params Evergreen.V43.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V43.Gen.Params.Login.Provider_.Callback.Params Evergreen.V43.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V43.Gen.Params.Stories.KatexDemo.Params
