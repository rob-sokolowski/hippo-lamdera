module Evergreen.V51.Gen.Msg exposing (..)

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


type Msg
    = Admin Evergreen.V51.Pages.Admin.Msg
    | Cards Evergreen.V51.Pages.Cards.Msg
    | Catalog Evergreen.V51.Pages.Catalog.Msg
    | Home_ Evergreen.V51.Pages.Home_.Msg
    | Login Evergreen.V51.Pages.Login.Msg
    | NotFound Evergreen.V51.Pages.NotFound.Msg
    | Study Evergreen.V51.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V51.Pages.Login.Provider_.Callback.Msg
    | Stories__KatexDemo Evergreen.V51.Pages.Stories.KatexDemo.Msg
    | Stories__VellumTesting Evergreen.V51.Pages.Stories.VellumTesting.Msg
