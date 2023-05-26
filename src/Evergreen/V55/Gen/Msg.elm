module Evergreen.V55.Gen.Msg exposing (..)

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


type Msg
    = Admin Evergreen.V55.Pages.Admin.Msg
    | Cards Evergreen.V55.Pages.Cards.Msg
    | Catalog Evergreen.V55.Pages.Catalog.Msg
    | Home_ Evergreen.V55.Pages.Home_.Msg
    | Login Evergreen.V55.Pages.Login.Msg
    | NotFound Evergreen.V55.Pages.NotFound.Msg
    | Study Evergreen.V55.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V55.Pages.Login.Provider_.Callback.Msg
    | Stories__KatexDemo Evergreen.V55.Pages.Stories.KatexDemo.Msg
    | Stories__VellumTesting Evergreen.V55.Pages.Stories.VellumTesting.Msg
