module Evergreen.V43.Gen.Msg exposing (..)

import Evergreen.V43.Pages.Admin
import Evergreen.V43.Pages.Cards
import Evergreen.V43.Pages.Catalog
import Evergreen.V43.Pages.Home_
import Evergreen.V43.Pages.Login
import Evergreen.V43.Pages.Login.Provider_.Callback
import Evergreen.V43.Pages.NotFound
import Evergreen.V43.Pages.Study


type Msg
    = Admin Evergreen.V43.Pages.Admin.Msg
    | Cards Evergreen.V43.Pages.Cards.Msg
    | Catalog Evergreen.V43.Pages.Catalog.Msg
    | Home_ Evergreen.V43.Pages.Home_.Msg
    | Login Evergreen.V43.Pages.Login.Msg
    | NotFound Evergreen.V43.Pages.NotFound.Msg
    | Study Evergreen.V43.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V43.Pages.Login.Provider_.Callback.Msg
