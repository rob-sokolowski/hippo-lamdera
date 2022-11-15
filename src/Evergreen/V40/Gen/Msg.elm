module Evergreen.V40.Gen.Msg exposing (..)

import Evergreen.V40.Pages.Admin
import Evergreen.V40.Pages.Cards
import Evergreen.V40.Pages.Catalog
import Evergreen.V40.Pages.Home_
import Evergreen.V40.Pages.Login
import Evergreen.V40.Pages.Login.Provider_.Callback
import Evergreen.V40.Pages.NotFound
import Evergreen.V40.Pages.Study


type Msg
    = Admin Evergreen.V40.Pages.Admin.Msg
    | Cards Evergreen.V40.Pages.Cards.Msg
    | Catalog Evergreen.V40.Pages.Catalog.Msg
    | Home_ Evergreen.V40.Pages.Home_.Msg
    | Login Evergreen.V40.Pages.Login.Msg
    | NotFound Evergreen.V40.Pages.NotFound.Msg
    | Study Evergreen.V40.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V40.Pages.Login.Provider_.Callback.Msg
