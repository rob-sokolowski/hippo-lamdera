module Evergreen.V25.Gen.Msg exposing (..)

import Evergreen.V25.Pages.Cards
import Evergreen.V25.Pages.Catalog
import Evergreen.V25.Pages.Home_
import Evergreen.V25.Pages.Login
import Evergreen.V25.Pages.Login.Provider_.Callback
import Evergreen.V25.Pages.NotFound
import Evergreen.V25.Pages.Study


type Msg
    = Cards Evergreen.V25.Pages.Cards.Msg
    | Catalog Evergreen.V25.Pages.Catalog.Msg
    | Home_ Evergreen.V25.Pages.Home_.Msg
    | Login Evergreen.V25.Pages.Login.Msg
    | NotFound Evergreen.V25.Pages.NotFound.Msg
    | Study Evergreen.V25.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V25.Pages.Login.Provider_.Callback.Msg
