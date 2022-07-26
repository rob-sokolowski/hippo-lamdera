module Evergreen.V26.Gen.Msg exposing (..)

import Evergreen.V26.Pages.Cards
import Evergreen.V26.Pages.Catalog
import Evergreen.V26.Pages.Home_
import Evergreen.V26.Pages.Login
import Evergreen.V26.Pages.Login.Provider_.Callback
import Evergreen.V26.Pages.NotFound
import Evergreen.V26.Pages.Study


type Msg
    = Cards Evergreen.V26.Pages.Cards.Msg
    | Catalog Evergreen.V26.Pages.Catalog.Msg
    | Home_ Evergreen.V26.Pages.Home_.Msg
    | Login Evergreen.V26.Pages.Login.Msg
    | NotFound Evergreen.V26.Pages.NotFound.Msg
    | Study Evergreen.V26.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V26.Pages.Login.Provider_.Callback.Msg
