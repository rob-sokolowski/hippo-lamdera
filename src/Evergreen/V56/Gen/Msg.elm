module Evergreen.V56.Gen.Msg exposing (..)

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


type Msg
    = Admin Evergreen.V56.Pages.Admin.Msg
    | Cards Evergreen.V56.Pages.Cards.Msg
    | Catalog Evergreen.V56.Pages.Catalog.Msg
    | Home_ Evergreen.V56.Pages.Home_.Msg
    | Login Evergreen.V56.Pages.Login.Msg
    | NotFound Evergreen.V56.Pages.NotFound.Msg
    | Study Evergreen.V56.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V56.Pages.Login.Provider_.Callback.Msg
    | Stories__KatexDemo Evergreen.V56.Pages.Stories.KatexDemo.Msg
    | Stories__VellumTesting Evergreen.V56.Pages.Stories.VellumTesting.Msg
