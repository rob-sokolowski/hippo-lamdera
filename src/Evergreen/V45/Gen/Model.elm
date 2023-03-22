module Evergreen.V45.Gen.Model exposing (..)

import Evergreen.V45.Gen.Params.Admin
import Evergreen.V45.Gen.Params.Cards
import Evergreen.V45.Gen.Params.Catalog
import Evergreen.V45.Gen.Params.Home_
import Evergreen.V45.Gen.Params.Login
import Evergreen.V45.Gen.Params.Login.Provider_.Callback
import Evergreen.V45.Gen.Params.NotFound
import Evergreen.V45.Gen.Params.Stories.KatexDemo
import Evergreen.V45.Gen.Params.Study
import Evergreen.V45.Pages.Admin
import Evergreen.V45.Pages.Cards
import Evergreen.V45.Pages.Catalog
import Evergreen.V45.Pages.Home_
import Evergreen.V45.Pages.Login
import Evergreen.V45.Pages.Login.Provider_.Callback
import Evergreen.V45.Pages.NotFound
import Evergreen.V45.Pages.Stories.KatexDemo
import Evergreen.V45.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V45.Gen.Params.Admin.Params Evergreen.V45.Pages.Admin.Model
    | Cards Evergreen.V45.Gen.Params.Cards.Params Evergreen.V45.Pages.Cards.Model
    | Catalog Evergreen.V45.Gen.Params.Catalog.Params Evergreen.V45.Pages.Catalog.Model
    | Home_ Evergreen.V45.Gen.Params.Home_.Params Evergreen.V45.Pages.Home_.Model
    | Login Evergreen.V45.Gen.Params.Login.Params Evergreen.V45.Pages.Login.Model
    | NotFound Evergreen.V45.Gen.Params.NotFound.Params Evergreen.V45.Pages.NotFound.Model
    | Study Evergreen.V45.Gen.Params.Study.Params Evergreen.V45.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V45.Gen.Params.Login.Provider_.Callback.Params Evergreen.V45.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V45.Gen.Params.Stories.KatexDemo.Params Evergreen.V45.Pages.Stories.KatexDemo.Model
