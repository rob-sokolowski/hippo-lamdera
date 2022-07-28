module Evergreen.V30.Gen.Msg exposing (..)

import Evergreen.V30.Pages.Cards
import Evergreen.V30.Pages.Catalog
import Evergreen.V30.Pages.Home_
import Evergreen.V30.Pages.Login
import Evergreen.V30.Pages.Login.Provider_.Callback
import Evergreen.V30.Pages.NotFound
import Evergreen.V30.Pages.Study


type Msg
    = Cards Evergreen.V30.Pages.Cards.Msg
    | Catalog Evergreen.V30.Pages.Catalog.Msg
    | Home_ Evergreen.V30.Pages.Home_.Msg
    | Login Evergreen.V30.Pages.Login.Msg
    | NotFound Evergreen.V30.Pages.NotFound.Msg
    | Study Evergreen.V30.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V30.Pages.Login.Provider_.Callback.Msg
