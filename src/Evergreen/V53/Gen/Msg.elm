module Evergreen.V53.Gen.Msg exposing (..)

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


type Msg
    = Admin Evergreen.V53.Pages.Admin.Msg
    | Cards Evergreen.V53.Pages.Cards.Msg
    | Catalog Evergreen.V53.Pages.Catalog.Msg
    | Home_ Evergreen.V53.Pages.Home_.Msg
    | Login Evergreen.V53.Pages.Login.Msg
    | NotFound Evergreen.V53.Pages.NotFound.Msg
    | Study Evergreen.V53.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V53.Pages.Login.Provider_.Callback.Msg
    | Stories__KatexDemo Evergreen.V53.Pages.Stories.KatexDemo.Msg
    | Stories__VellumTesting Evergreen.V53.Pages.Stories.VellumTesting.Msg
