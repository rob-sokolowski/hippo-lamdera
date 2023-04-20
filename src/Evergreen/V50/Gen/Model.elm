module Evergreen.V50.Gen.Model exposing (..)

import Evergreen.V50.Gen.Params.Admin
import Evergreen.V50.Gen.Params.Cards
import Evergreen.V50.Gen.Params.Catalog
import Evergreen.V50.Gen.Params.Home_
import Evergreen.V50.Gen.Params.Login
import Evergreen.V50.Gen.Params.Login.Provider_.Callback
import Evergreen.V50.Gen.Params.NotFound
import Evergreen.V50.Gen.Params.Stories.KatexDemo
import Evergreen.V50.Gen.Params.Study
import Evergreen.V50.Pages.Admin
import Evergreen.V50.Pages.Cards
import Evergreen.V50.Pages.Catalog
import Evergreen.V50.Pages.Home_
import Evergreen.V50.Pages.Login
import Evergreen.V50.Pages.Login.Provider_.Callback
import Evergreen.V50.Pages.NotFound
import Evergreen.V50.Pages.Stories.KatexDemo
import Evergreen.V50.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V50.Gen.Params.Admin.Params Evergreen.V50.Pages.Admin.Model
    | Cards Evergreen.V50.Gen.Params.Cards.Params Evergreen.V50.Pages.Cards.Model
    | Catalog Evergreen.V50.Gen.Params.Catalog.Params Evergreen.V50.Pages.Catalog.Model
    | Home_ Evergreen.V50.Gen.Params.Home_.Params Evergreen.V50.Pages.Home_.Model
    | Login Evergreen.V50.Gen.Params.Login.Params Evergreen.V50.Pages.Login.Model
    | NotFound Evergreen.V50.Gen.Params.NotFound.Params Evergreen.V50.Pages.NotFound.Model
    | Study Evergreen.V50.Gen.Params.Study.Params Evergreen.V50.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V50.Gen.Params.Login.Provider_.Callback.Params Evergreen.V50.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V50.Gen.Params.Stories.KatexDemo.Params Evergreen.V50.Pages.Stories.KatexDemo.Model
