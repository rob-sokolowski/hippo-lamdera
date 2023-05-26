module Evergreen.V54.Gen.Model exposing (..)

import Evergreen.V54.Gen.Params.Admin
import Evergreen.V54.Gen.Params.Cards
import Evergreen.V54.Gen.Params.Catalog
import Evergreen.V54.Gen.Params.Home_
import Evergreen.V54.Gen.Params.Login
import Evergreen.V54.Gen.Params.Login.Provider_.Callback
import Evergreen.V54.Gen.Params.NotFound
import Evergreen.V54.Gen.Params.Stories.KatexDemo
import Evergreen.V54.Gen.Params.Stories.VellumTesting
import Evergreen.V54.Gen.Params.Study
import Evergreen.V54.Pages.Admin
import Evergreen.V54.Pages.Cards
import Evergreen.V54.Pages.Catalog
import Evergreen.V54.Pages.Home_
import Evergreen.V54.Pages.Login
import Evergreen.V54.Pages.Login.Provider_.Callback
import Evergreen.V54.Pages.NotFound
import Evergreen.V54.Pages.Stories.KatexDemo
import Evergreen.V54.Pages.Stories.VellumTesting
import Evergreen.V54.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V54.Gen.Params.Admin.Params Evergreen.V54.Pages.Admin.Model
    | Cards Evergreen.V54.Gen.Params.Cards.Params Evergreen.V54.Pages.Cards.Model
    | Catalog Evergreen.V54.Gen.Params.Catalog.Params Evergreen.V54.Pages.Catalog.Model
    | Home_ Evergreen.V54.Gen.Params.Home_.Params Evergreen.V54.Pages.Home_.Model
    | Login Evergreen.V54.Gen.Params.Login.Params Evergreen.V54.Pages.Login.Model
    | NotFound Evergreen.V54.Gen.Params.NotFound.Params Evergreen.V54.Pages.NotFound.Model
    | Study Evergreen.V54.Gen.Params.Study.Params Evergreen.V54.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V54.Gen.Params.Login.Provider_.Callback.Params Evergreen.V54.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V54.Gen.Params.Stories.KatexDemo.Params Evergreen.V54.Pages.Stories.KatexDemo.Model
    | Stories__VellumTesting Evergreen.V54.Gen.Params.Stories.VellumTesting.Params Evergreen.V54.Pages.Stories.VellumTesting.Model
