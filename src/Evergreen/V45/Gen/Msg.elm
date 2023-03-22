module Evergreen.V45.Gen.Msg exposing (..)

import Evergreen.V45.Pages.Admin
import Evergreen.V45.Pages.Cards
import Evergreen.V45.Pages.Catalog
import Evergreen.V45.Pages.Home_
import Evergreen.V45.Pages.Login
import Evergreen.V45.Pages.Login.Provider_.Callback
import Evergreen.V45.Pages.NotFound
import Evergreen.V45.Pages.Stories.KatexDemo
import Evergreen.V45.Pages.Study


type Msg
    = Admin Evergreen.V45.Pages.Admin.Msg
    | Cards Evergreen.V45.Pages.Cards.Msg
    | Catalog Evergreen.V45.Pages.Catalog.Msg
    | Home_ Evergreen.V45.Pages.Home_.Msg
    | Login Evergreen.V45.Pages.Login.Msg
    | NotFound Evergreen.V45.Pages.NotFound.Msg
    | Study Evergreen.V45.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V45.Pages.Login.Provider_.Callback.Msg
    | Stories__KatexDemo Evergreen.V45.Pages.Stories.KatexDemo.Msg
