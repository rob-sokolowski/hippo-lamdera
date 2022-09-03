module Evergreen.V37.Gen.Msg exposing (..)

import Evergreen.V37.Pages.Admin
import Evergreen.V37.Pages.Cards
import Evergreen.V37.Pages.Catalog
import Evergreen.V37.Pages.Home_
import Evergreen.V37.Pages.Login
import Evergreen.V37.Pages.Login.Provider_.Callback
import Evergreen.V37.Pages.NotFound
import Evergreen.V37.Pages.Study


type Msg
    = Admin Evergreen.V37.Pages.Admin.Msg
    | Cards Evergreen.V37.Pages.Cards.Msg
    | Catalog Evergreen.V37.Pages.Catalog.Msg
    | Home_ Evergreen.V37.Pages.Home_.Msg
    | Login Evergreen.V37.Pages.Login.Msg
    | NotFound Evergreen.V37.Pages.NotFound.Msg
    | Study Evergreen.V37.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V37.Pages.Login.Provider_.Callback.Msg
