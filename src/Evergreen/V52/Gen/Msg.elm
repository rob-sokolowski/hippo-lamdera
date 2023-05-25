module Evergreen.V52.Gen.Msg exposing (..)

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


type Msg
    = Admin Evergreen.V52.Pages.Admin.Msg
    | Cards Evergreen.V52.Pages.Cards.Msg
    | Catalog Evergreen.V52.Pages.Catalog.Msg
    | Home_ Evergreen.V52.Pages.Home_.Msg
    | Login Evergreen.V52.Pages.Login.Msg
    | NotFound Evergreen.V52.Pages.NotFound.Msg
    | Study Evergreen.V52.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V52.Pages.Login.Provider_.Callback.Msg
    | Stories__KatexDemo Evergreen.V52.Pages.Stories.KatexDemo.Msg
    | Stories__VellumTesting Evergreen.V52.Pages.Stories.VellumTesting.Msg
