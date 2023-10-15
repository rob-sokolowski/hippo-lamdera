module Gen.Model exposing (Model(..))

import Gen.Params.Admin
import Gen.Params.Cards
import Gen.Params.Catalog
import Gen.Params.Home_
import Gen.Params.Login
import Gen.Params.NotFound
import Gen.Params.Study
import Gen.Params.Login.Provider_.Callback
import Gen.Params.Stories.ElmAudio
import Gen.Params.Stories.KatexDemo
import Gen.Params.Stories.VellumTesting
import Pages.Admin
import Pages.Cards
import Pages.Catalog
import Pages.Home_
import Pages.Login
import Pages.NotFound
import Pages.Study
import Pages.Login.Provider_.Callback
import Pages.Stories.ElmAudio
import Pages.Stories.KatexDemo
import Pages.Stories.VellumTesting


type Model
    = Redirecting_
    | Admin Gen.Params.Admin.Params Pages.Admin.Model
    | Cards Gen.Params.Cards.Params Pages.Cards.Model
    | Catalog Gen.Params.Catalog.Params Pages.Catalog.Model
    | Home_ Gen.Params.Home_.Params Pages.Home_.Model
    | Login Gen.Params.Login.Params Pages.Login.Model
    | NotFound Gen.Params.NotFound.Params Pages.NotFound.Model
    | Study Gen.Params.Study.Params Pages.Study.Model
    | Login__Provider___Callback Gen.Params.Login.Provider_.Callback.Params Pages.Login.Provider_.Callback.Model
    | Stories__ElmAudio Gen.Params.Stories.ElmAudio.Params Pages.Stories.ElmAudio.Model
    | Stories__KatexDemo Gen.Params.Stories.KatexDemo.Params Pages.Stories.KatexDemo.Model
    | Stories__VellumTesting Gen.Params.Stories.VellumTesting.Params Pages.Stories.VellumTesting.Model

