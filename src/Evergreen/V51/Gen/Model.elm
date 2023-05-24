module Evergreen.V51.Gen.Model exposing (..)

import Evergreen.V51.Gen.Params.Admin
import Evergreen.V51.Gen.Params.Cards
import Evergreen.V51.Gen.Params.Catalog
import Evergreen.V51.Gen.Params.Home_
import Evergreen.V51.Gen.Params.Login
import Evergreen.V51.Gen.Params.Login.Provider_.Callback
import Evergreen.V51.Gen.Params.NotFound
import Evergreen.V51.Gen.Params.Stories.KatexDemo
import Evergreen.V51.Gen.Params.Stories.VellumTesting
import Evergreen.V51.Gen.Params.Study
import Evergreen.V51.Pages.Admin
import Evergreen.V51.Pages.Cards
import Evergreen.V51.Pages.Catalog
import Evergreen.V51.Pages.Home_
import Evergreen.V51.Pages.Login
import Evergreen.V51.Pages.Login.Provider_.Callback
import Evergreen.V51.Pages.NotFound
import Evergreen.V51.Pages.Stories.KatexDemo
import Evergreen.V51.Pages.Stories.VellumTesting
import Evergreen.V51.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V51.Gen.Params.Admin.Params Evergreen.V51.Pages.Admin.Model
    | Cards Evergreen.V51.Gen.Params.Cards.Params Evergreen.V51.Pages.Cards.Model
    | Catalog Evergreen.V51.Gen.Params.Catalog.Params Evergreen.V51.Pages.Catalog.Model
    | Home_ Evergreen.V51.Gen.Params.Home_.Params Evergreen.V51.Pages.Home_.Model
    | Login Evergreen.V51.Gen.Params.Login.Params Evergreen.V51.Pages.Login.Model
    | NotFound Evergreen.V51.Gen.Params.NotFound.Params Evergreen.V51.Pages.NotFound.Model
    | Study Evergreen.V51.Gen.Params.Study.Params Evergreen.V51.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V51.Gen.Params.Login.Provider_.Callback.Params Evergreen.V51.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V51.Gen.Params.Stories.KatexDemo.Params Evergreen.V51.Pages.Stories.KatexDemo.Model
    | Stories__VellumTesting Evergreen.V51.Gen.Params.Stories.VellumTesting.Params Evergreen.V51.Pages.Stories.VellumTesting.Model
