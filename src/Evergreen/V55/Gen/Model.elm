module Evergreen.V55.Gen.Model exposing (..)

import Evergreen.V55.Gen.Params.Admin
import Evergreen.V55.Gen.Params.Cards
import Evergreen.V55.Gen.Params.Catalog
import Evergreen.V55.Gen.Params.Home_
import Evergreen.V55.Gen.Params.Login
import Evergreen.V55.Gen.Params.Login.Provider_.Callback
import Evergreen.V55.Gen.Params.NotFound
import Evergreen.V55.Gen.Params.Stories.KatexDemo
import Evergreen.V55.Gen.Params.Stories.VellumTesting
import Evergreen.V55.Gen.Params.Study
import Evergreen.V55.Pages.Admin
import Evergreen.V55.Pages.Cards
import Evergreen.V55.Pages.Catalog
import Evergreen.V55.Pages.Home_
import Evergreen.V55.Pages.Login
import Evergreen.V55.Pages.Login.Provider_.Callback
import Evergreen.V55.Pages.NotFound
import Evergreen.V55.Pages.Stories.KatexDemo
import Evergreen.V55.Pages.Stories.VellumTesting
import Evergreen.V55.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V55.Gen.Params.Admin.Params Evergreen.V55.Pages.Admin.Model
    | Cards Evergreen.V55.Gen.Params.Cards.Params Evergreen.V55.Pages.Cards.Model
    | Catalog Evergreen.V55.Gen.Params.Catalog.Params Evergreen.V55.Pages.Catalog.Model
    | Home_ Evergreen.V55.Gen.Params.Home_.Params Evergreen.V55.Pages.Home_.Model
    | Login Evergreen.V55.Gen.Params.Login.Params Evergreen.V55.Pages.Login.Model
    | NotFound Evergreen.V55.Gen.Params.NotFound.Params Evergreen.V55.Pages.NotFound.Model
    | Study Evergreen.V55.Gen.Params.Study.Params Evergreen.V55.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V55.Gen.Params.Login.Provider_.Callback.Params Evergreen.V55.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V55.Gen.Params.Stories.KatexDemo.Params Evergreen.V55.Pages.Stories.KatexDemo.Model
    | Stories__VellumTesting Evergreen.V55.Gen.Params.Stories.VellumTesting.Params Evergreen.V55.Pages.Stories.VellumTesting.Model
