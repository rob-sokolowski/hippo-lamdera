module Evergreen.V60.Gen.Model exposing (..)

import Evergreen.V60.Gen.Params.Admin
import Evergreen.V60.Gen.Params.Cards
import Evergreen.V60.Gen.Params.Catalog
import Evergreen.V60.Gen.Params.Home_
import Evergreen.V60.Gen.Params.Login
import Evergreen.V60.Gen.Params.Login.Provider_.Callback
import Evergreen.V60.Gen.Params.NotFound
import Evergreen.V60.Gen.Params.Stories.ElmAudio
import Evergreen.V60.Gen.Params.Stories.KatexDemo
import Evergreen.V60.Gen.Params.Stories.VellumTesting
import Evergreen.V60.Gen.Params.Study
import Evergreen.V60.Pages.Admin
import Evergreen.V60.Pages.Cards
import Evergreen.V60.Pages.Catalog
import Evergreen.V60.Pages.Home_
import Evergreen.V60.Pages.Login
import Evergreen.V60.Pages.Login.Provider_.Callback
import Evergreen.V60.Pages.NotFound
import Evergreen.V60.Pages.Stories.ElmAudio
import Evergreen.V60.Pages.Stories.KatexDemo
import Evergreen.V60.Pages.Stories.VellumTesting
import Evergreen.V60.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V60.Gen.Params.Admin.Params Evergreen.V60.Pages.Admin.Model
    | Cards Evergreen.V60.Gen.Params.Cards.Params Evergreen.V60.Pages.Cards.Model
    | Catalog Evergreen.V60.Gen.Params.Catalog.Params Evergreen.V60.Pages.Catalog.Model
    | Home_ Evergreen.V60.Gen.Params.Home_.Params Evergreen.V60.Pages.Home_.Model
    | Login Evergreen.V60.Gen.Params.Login.Params Evergreen.V60.Pages.Login.Model
    | NotFound Evergreen.V60.Gen.Params.NotFound.Params Evergreen.V60.Pages.NotFound.Model
    | Study Evergreen.V60.Gen.Params.Study.Params Evergreen.V60.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V60.Gen.Params.Login.Provider_.Callback.Params Evergreen.V60.Pages.Login.Provider_.Callback.Model
    | Stories__ElmAudio Evergreen.V60.Gen.Params.Stories.ElmAudio.Params Evergreen.V60.Pages.Stories.ElmAudio.Model
    | Stories__KatexDemo Evergreen.V60.Gen.Params.Stories.KatexDemo.Params Evergreen.V60.Pages.Stories.KatexDemo.Model
    | Stories__VellumTesting Evergreen.V60.Gen.Params.Stories.VellumTesting.Params Evergreen.V60.Pages.Stories.VellumTesting.Model
