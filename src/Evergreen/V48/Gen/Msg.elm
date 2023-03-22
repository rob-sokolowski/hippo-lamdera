module Evergreen.V48.Gen.Msg exposing (..)

import Evergreen.V48.Pages.Admin
import Evergreen.V48.Pages.Cards
import Evergreen.V48.Pages.Catalog
import Evergreen.V48.Pages.Home_
import Evergreen.V48.Pages.Login
import Evergreen.V48.Pages.Login.Provider_.Callback
import Evergreen.V48.Pages.NotFound
import Evergreen.V48.Pages.Stories.KatexDemo
import Evergreen.V48.Pages.Study


type Msg
    = Admin Evergreen.V48.Pages.Admin.Msg
    | Cards Evergreen.V48.Pages.Cards.Msg
    | Catalog Evergreen.V48.Pages.Catalog.Msg
    | Home_ Evergreen.V48.Pages.Home_.Msg
    | Login Evergreen.V48.Pages.Login.Msg
    | NotFound Evergreen.V48.Pages.NotFound.Msg
    | Study Evergreen.V48.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V48.Pages.Login.Provider_.Callback.Msg
    | Stories__KatexDemo Evergreen.V48.Pages.Stories.KatexDemo.Msg
