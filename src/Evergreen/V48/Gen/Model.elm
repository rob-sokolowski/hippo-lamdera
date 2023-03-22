module Evergreen.V48.Gen.Model exposing (..)

import Evergreen.V48.Gen.Params.Admin
import Evergreen.V48.Gen.Params.Cards
import Evergreen.V48.Gen.Params.Catalog
import Evergreen.V48.Gen.Params.Home_
import Evergreen.V48.Gen.Params.Login
import Evergreen.V48.Gen.Params.Login.Provider_.Callback
import Evergreen.V48.Gen.Params.NotFound
import Evergreen.V48.Gen.Params.Stories.KatexDemo
import Evergreen.V48.Gen.Params.Study
import Evergreen.V48.Pages.Admin
import Evergreen.V48.Pages.Cards
import Evergreen.V48.Pages.Catalog
import Evergreen.V48.Pages.Home_
import Evergreen.V48.Pages.Login
import Evergreen.V48.Pages.Login.Provider_.Callback
import Evergreen.V48.Pages.NotFound
import Evergreen.V48.Pages.Stories.KatexDemo
import Evergreen.V48.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V48.Gen.Params.Admin.Params Evergreen.V48.Pages.Admin.Model
    | Cards Evergreen.V48.Gen.Params.Cards.Params Evergreen.V48.Pages.Cards.Model
    | Catalog Evergreen.V48.Gen.Params.Catalog.Params Evergreen.V48.Pages.Catalog.Model
    | Home_ Evergreen.V48.Gen.Params.Home_.Params Evergreen.V48.Pages.Home_.Model
    | Login Evergreen.V48.Gen.Params.Login.Params Evergreen.V48.Pages.Login.Model
    | NotFound Evergreen.V48.Gen.Params.NotFound.Params Evergreen.V48.Pages.NotFound.Model
    | Study Evergreen.V48.Gen.Params.Study.Params Evergreen.V48.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V48.Gen.Params.Login.Provider_.Callback.Params Evergreen.V48.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V48.Gen.Params.Stories.KatexDemo.Params Evergreen.V48.Pages.Stories.KatexDemo.Model
