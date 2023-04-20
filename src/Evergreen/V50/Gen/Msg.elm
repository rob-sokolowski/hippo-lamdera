module Evergreen.V50.Gen.Msg exposing (..)

import Evergreen.V50.Pages.Admin
import Evergreen.V50.Pages.Cards
import Evergreen.V50.Pages.Catalog
import Evergreen.V50.Pages.Home_
import Evergreen.V50.Pages.Login
import Evergreen.V50.Pages.Login.Provider_.Callback
import Evergreen.V50.Pages.NotFound
import Evergreen.V50.Pages.Stories.KatexDemo
import Evergreen.V50.Pages.Study


type Msg
    = Admin Evergreen.V50.Pages.Admin.Msg
    | Cards Evergreen.V50.Pages.Cards.Msg
    | Catalog Evergreen.V50.Pages.Catalog.Msg
    | Home_ Evergreen.V50.Pages.Home_.Msg
    | Login Evergreen.V50.Pages.Login.Msg
    | NotFound Evergreen.V50.Pages.NotFound.Msg
    | Study Evergreen.V50.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V50.Pages.Login.Provider_.Callback.Msg
    | Stories__KatexDemo Evergreen.V50.Pages.Stories.KatexDemo.Msg
