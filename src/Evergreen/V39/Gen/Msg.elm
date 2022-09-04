module Evergreen.V39.Gen.Msg exposing (..)

import Evergreen.V39.Pages.Admin
import Evergreen.V39.Pages.Cards
import Evergreen.V39.Pages.Catalog
import Evergreen.V39.Pages.Home_
import Evergreen.V39.Pages.Login
import Evergreen.V39.Pages.Login.Provider_.Callback
import Evergreen.V39.Pages.NotFound
import Evergreen.V39.Pages.Study


type Msg
    = Admin Evergreen.V39.Pages.Admin.Msg
    | Cards Evergreen.V39.Pages.Cards.Msg
    | Catalog Evergreen.V39.Pages.Catalog.Msg
    | Home_ Evergreen.V39.Pages.Home_.Msg
    | Login Evergreen.V39.Pages.Login.Msg
    | NotFound Evergreen.V39.Pages.NotFound.Msg
    | Study Evergreen.V39.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V39.Pages.Login.Provider_.Callback.Msg
