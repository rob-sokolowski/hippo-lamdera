module Evergreen.V28.Gen.Msg exposing (..)

import Evergreen.V28.Pages.Cards
import Evergreen.V28.Pages.Catalog
import Evergreen.V28.Pages.Home_
import Evergreen.V28.Pages.Login
import Evergreen.V28.Pages.Login.Provider_.Callback
import Evergreen.V28.Pages.NotFound
import Evergreen.V28.Pages.Study


type Msg
    = Cards Evergreen.V28.Pages.Cards.Msg
    | Catalog Evergreen.V28.Pages.Catalog.Msg
    | Home_ Evergreen.V28.Pages.Home_.Msg
    | Login Evergreen.V28.Pages.Login.Msg
    | NotFound Evergreen.V28.Pages.NotFound.Msg
    | Study Evergreen.V28.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V28.Pages.Login.Provider_.Callback.Msg
