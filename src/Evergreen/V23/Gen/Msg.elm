module Evergreen.V23.Gen.Msg exposing (..)

import Evergreen.V23.Pages.Cards
import Evergreen.V23.Pages.Catalog
import Evergreen.V23.Pages.Home_
import Evergreen.V23.Pages.Login
import Evergreen.V23.Pages.NotFound
import Evergreen.V23.Pages.Register
import Evergreen.V23.Pages.Study


type Msg
    = Cards Evergreen.V23.Pages.Cards.Msg
    | Catalog Evergreen.V23.Pages.Catalog.Msg
    | Home_ Evergreen.V23.Pages.Home_.Msg
    | Login Evergreen.V23.Pages.Login.Msg
    | NotFound Evergreen.V23.Pages.NotFound.Msg
    | Register Evergreen.V23.Pages.Register.Msg
    | Study Evergreen.V23.Pages.Study.Msg
