module Evergreen.V49.Gen.Model exposing (..)

import Evergreen.V49.Gen.Params.Admin
import Evergreen.V49.Gen.Params.Cards
import Evergreen.V49.Gen.Params.Catalog
import Evergreen.V49.Gen.Params.Home_
import Evergreen.V49.Gen.Params.Login
import Evergreen.V49.Gen.Params.Login.Provider_.Callback
import Evergreen.V49.Gen.Params.NotFound
import Evergreen.V49.Gen.Params.Stories.KatexDemo
import Evergreen.V49.Gen.Params.Study
import Evergreen.V49.Pages.Admin
import Evergreen.V49.Pages.Cards
import Evergreen.V49.Pages.Catalog
import Evergreen.V49.Pages.Home_
import Evergreen.V49.Pages.Login
import Evergreen.V49.Pages.Login.Provider_.Callback
import Evergreen.V49.Pages.NotFound
import Evergreen.V49.Pages.Stories.KatexDemo
import Evergreen.V49.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V49.Gen.Params.Admin.Params Evergreen.V49.Pages.Admin.Model
    | Cards Evergreen.V49.Gen.Params.Cards.Params Evergreen.V49.Pages.Cards.Model
    | Catalog Evergreen.V49.Gen.Params.Catalog.Params Evergreen.V49.Pages.Catalog.Model
    | Home_ Evergreen.V49.Gen.Params.Home_.Params Evergreen.V49.Pages.Home_.Model
    | Login Evergreen.V49.Gen.Params.Login.Params Evergreen.V49.Pages.Login.Model
    | NotFound Evergreen.V49.Gen.Params.NotFound.Params Evergreen.V49.Pages.NotFound.Model
    | Study Evergreen.V49.Gen.Params.Study.Params Evergreen.V49.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V49.Gen.Params.Login.Provider_.Callback.Params Evergreen.V49.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V49.Gen.Params.Stories.KatexDemo.Params Evergreen.V49.Pages.Stories.KatexDemo.Model
