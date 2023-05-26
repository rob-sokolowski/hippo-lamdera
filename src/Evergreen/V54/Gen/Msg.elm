module Evergreen.V54.Gen.Msg exposing (..)

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


type Msg
    = Admin Evergreen.V54.Pages.Admin.Msg
    | Cards Evergreen.V54.Pages.Cards.Msg
    | Catalog Evergreen.V54.Pages.Catalog.Msg
    | Home_ Evergreen.V54.Pages.Home_.Msg
    | Login Evergreen.V54.Pages.Login.Msg
    | NotFound Evergreen.V54.Pages.NotFound.Msg
    | Study Evergreen.V54.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V54.Pages.Login.Provider_.Callback.Msg
    | Stories__KatexDemo Evergreen.V54.Pages.Stories.KatexDemo.Msg
    | Stories__VellumTesting Evergreen.V54.Pages.Stories.VellumTesting.Msg
