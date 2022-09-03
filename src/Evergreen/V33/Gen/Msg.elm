module Evergreen.V33.Gen.Msg exposing (..)

import Evergreen.V33.Pages.Cards
import Evergreen.V33.Pages.Catalog
import Evergreen.V33.Pages.Home_
import Evergreen.V33.Pages.Login
import Evergreen.V33.Pages.Login.Provider_.Callback
import Evergreen.V33.Pages.NotFound
import Evergreen.V33.Pages.Study


type Msg
    = Cards Evergreen.V33.Pages.Cards.Msg
    | Catalog Evergreen.V33.Pages.Catalog.Msg
    | Home_ Evergreen.V33.Pages.Home_.Msg
    | Login Evergreen.V33.Pages.Login.Msg
    | NotFound Evergreen.V33.Pages.NotFound.Msg
    | Study Evergreen.V33.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V33.Pages.Login.Provider_.Callback.Msg
