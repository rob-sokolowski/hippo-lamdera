module Evergreen.V53.Gen.Model exposing (..)

import Evergreen.V53.Gen.Params.Admin
import Evergreen.V53.Gen.Params.Cards
import Evergreen.V53.Gen.Params.Catalog
import Evergreen.V53.Gen.Params.Home_
import Evergreen.V53.Gen.Params.Login
import Evergreen.V53.Gen.Params.Login.Provider_.Callback
import Evergreen.V53.Gen.Params.NotFound
import Evergreen.V53.Gen.Params.Stories.KatexDemo
import Evergreen.V53.Gen.Params.Stories.VellumTesting
import Evergreen.V53.Gen.Params.Study
import Evergreen.V53.Pages.Admin
import Evergreen.V53.Pages.Cards
import Evergreen.V53.Pages.Catalog
import Evergreen.V53.Pages.Home_
import Evergreen.V53.Pages.Login
import Evergreen.V53.Pages.Login.Provider_.Callback
import Evergreen.V53.Pages.NotFound
import Evergreen.V53.Pages.Stories.KatexDemo
import Evergreen.V53.Pages.Stories.VellumTesting
import Evergreen.V53.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V53.Gen.Params.Admin.Params Evergreen.V53.Pages.Admin.Model
    | Cards Evergreen.V53.Gen.Params.Cards.Params Evergreen.V53.Pages.Cards.Model
    | Catalog Evergreen.V53.Gen.Params.Catalog.Params Evergreen.V53.Pages.Catalog.Model
    | Home_ Evergreen.V53.Gen.Params.Home_.Params Evergreen.V53.Pages.Home_.Model
    | Login Evergreen.V53.Gen.Params.Login.Params Evergreen.V53.Pages.Login.Model
    | NotFound Evergreen.V53.Gen.Params.NotFound.Params Evergreen.V53.Pages.NotFound.Model
    | Study Evergreen.V53.Gen.Params.Study.Params Evergreen.V53.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V53.Gen.Params.Login.Provider_.Callback.Params Evergreen.V53.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V53.Gen.Params.Stories.KatexDemo.Params Evergreen.V53.Pages.Stories.KatexDemo.Model
    | Stories__VellumTesting Evergreen.V53.Gen.Params.Stories.VellumTesting.Params Evergreen.V53.Pages.Stories.VellumTesting.Model
