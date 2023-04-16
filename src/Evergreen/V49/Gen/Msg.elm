module Evergreen.V49.Gen.Msg exposing (..)

import Evergreen.V49.Pages.Admin
import Evergreen.V49.Pages.Cards
import Evergreen.V49.Pages.Catalog
import Evergreen.V49.Pages.Home_
import Evergreen.V49.Pages.Login
import Evergreen.V49.Pages.Login.Provider_.Callback
import Evergreen.V49.Pages.NotFound
import Evergreen.V49.Pages.Stories.KatexDemo
import Evergreen.V49.Pages.Study


type Msg
    = Admin Evergreen.V49.Pages.Admin.Msg
    | Cards Evergreen.V49.Pages.Cards.Msg
    | Catalog Evergreen.V49.Pages.Catalog.Msg
    | Home_ Evergreen.V49.Pages.Home_.Msg
    | Login Evergreen.V49.Pages.Login.Msg
    | NotFound Evergreen.V49.Pages.NotFound.Msg
    | Study Evergreen.V49.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V49.Pages.Login.Provider_.Callback.Msg
    | Stories__KatexDemo Evergreen.V49.Pages.Stories.KatexDemo.Msg
