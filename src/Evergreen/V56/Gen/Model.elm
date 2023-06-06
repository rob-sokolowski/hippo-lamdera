module Evergreen.V56.Gen.Model exposing (..)

import Evergreen.V56.Gen.Params.Admin
import Evergreen.V56.Gen.Params.Cards
import Evergreen.V56.Gen.Params.Catalog
import Evergreen.V56.Gen.Params.Home_
import Evergreen.V56.Gen.Params.Login
import Evergreen.V56.Gen.Params.Login.Provider_.Callback
import Evergreen.V56.Gen.Params.NotFound
import Evergreen.V56.Gen.Params.Stories.KatexDemo
import Evergreen.V56.Gen.Params.Stories.VellumTesting
import Evergreen.V56.Gen.Params.Study
import Evergreen.V56.Pages.Admin
import Evergreen.V56.Pages.Cards
import Evergreen.V56.Pages.Catalog
import Evergreen.V56.Pages.Home_
import Evergreen.V56.Pages.Login
import Evergreen.V56.Pages.Login.Provider_.Callback
import Evergreen.V56.Pages.NotFound
import Evergreen.V56.Pages.Stories.KatexDemo
import Evergreen.V56.Pages.Stories.VellumTesting
import Evergreen.V56.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V56.Gen.Params.Admin.Params Evergreen.V56.Pages.Admin.Model
    | Cards Evergreen.V56.Gen.Params.Cards.Params Evergreen.V56.Pages.Cards.Model
    | Catalog Evergreen.V56.Gen.Params.Catalog.Params Evergreen.V56.Pages.Catalog.Model
    | Home_ Evergreen.V56.Gen.Params.Home_.Params Evergreen.V56.Pages.Home_.Model
    | Login Evergreen.V56.Gen.Params.Login.Params Evergreen.V56.Pages.Login.Model
    | NotFound Evergreen.V56.Gen.Params.NotFound.Params Evergreen.V56.Pages.NotFound.Model
    | Study Evergreen.V56.Gen.Params.Study.Params Evergreen.V56.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V56.Gen.Params.Login.Provider_.Callback.Params Evergreen.V56.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V56.Gen.Params.Stories.KatexDemo.Params Evergreen.V56.Pages.Stories.KatexDemo.Model
    | Stories__VellumTesting Evergreen.V56.Gen.Params.Stories.VellumTesting.Params Evergreen.V56.Pages.Stories.VellumTesting.Model
