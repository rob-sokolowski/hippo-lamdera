module Evergreen.V52.Gen.Model exposing (..)

import Evergreen.V52.Gen.Params.Admin
import Evergreen.V52.Gen.Params.Cards
import Evergreen.V52.Gen.Params.Catalog
import Evergreen.V52.Gen.Params.Home_
import Evergreen.V52.Gen.Params.Login
import Evergreen.V52.Gen.Params.Login.Provider_.Callback
import Evergreen.V52.Gen.Params.NotFound
import Evergreen.V52.Gen.Params.Stories.KatexDemo
import Evergreen.V52.Gen.Params.Stories.VellumTesting
import Evergreen.V52.Gen.Params.Study
import Evergreen.V52.Pages.Admin
import Evergreen.V52.Pages.Cards
import Evergreen.V52.Pages.Catalog
import Evergreen.V52.Pages.Home_
import Evergreen.V52.Pages.Login
import Evergreen.V52.Pages.Login.Provider_.Callback
import Evergreen.V52.Pages.NotFound
import Evergreen.V52.Pages.Stories.KatexDemo
import Evergreen.V52.Pages.Stories.VellumTesting
import Evergreen.V52.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V52.Gen.Params.Admin.Params Evergreen.V52.Pages.Admin.Model
    | Cards Evergreen.V52.Gen.Params.Cards.Params Evergreen.V52.Pages.Cards.Model
    | Catalog Evergreen.V52.Gen.Params.Catalog.Params Evergreen.V52.Pages.Catalog.Model
    | Home_ Evergreen.V52.Gen.Params.Home_.Params Evergreen.V52.Pages.Home_.Model
    | Login Evergreen.V52.Gen.Params.Login.Params Evergreen.V52.Pages.Login.Model
    | NotFound Evergreen.V52.Gen.Params.NotFound.Params Evergreen.V52.Pages.NotFound.Model
    | Study Evergreen.V52.Gen.Params.Study.Params Evergreen.V52.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V52.Gen.Params.Login.Provider_.Callback.Params Evergreen.V52.Pages.Login.Provider_.Callback.Model
    | Stories__KatexDemo Evergreen.V52.Gen.Params.Stories.KatexDemo.Params Evergreen.V52.Pages.Stories.KatexDemo.Model
    | Stories__VellumTesting Evergreen.V52.Gen.Params.Stories.VellumTesting.Params Evergreen.V52.Pages.Stories.VellumTesting.Model
