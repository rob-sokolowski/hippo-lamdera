module Evergreen.V22.Gen.Msg exposing (..)

import Evergreen.V22.Pages.Cards
import Evergreen.V22.Pages.Catalog
import Evergreen.V22.Pages.Home_
import Evergreen.V22.Pages.Login
import Evergreen.V22.Pages.NotFound
import Evergreen.V22.Pages.Profile.Username_
import Evergreen.V22.Pages.Register
import Evergreen.V22.Pages.Study


type Msg
    = Cards Evergreen.V22.Pages.Cards.Msg
    | Catalog Evergreen.V22.Pages.Catalog.Msg
    | Home_ Evergreen.V22.Pages.Home_.Msg
    | Login Evergreen.V22.Pages.Login.Msg
    | NotFound Evergreen.V22.Pages.NotFound.Msg
    | Register Evergreen.V22.Pages.Register.Msg
    | Study Evergreen.V22.Pages.Study.Msg
    | Profile__Username_ Evergreen.V22.Pages.Profile.Username_.Msg
