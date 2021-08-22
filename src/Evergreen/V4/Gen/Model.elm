module Evergreen.V4.Gen.Model exposing (..)

import Evergreen.V4.Gen.Params.Cards
import Evergreen.V4.Gen.Params.Home_
import Evergreen.V4.Gen.Params.Login
import Evergreen.V4.Gen.Params.NotFound
import Evergreen.V4.Gen.Params.Profile.Username_
import Evergreen.V4.Gen.Params.Register
import Evergreen.V4.Gen.Params.Settings
import Evergreen.V4.Pages.Cards
import Evergreen.V4.Pages.Home_
import Evergreen.V4.Pages.Login
import Evergreen.V4.Pages.Profile.Username_
import Evergreen.V4.Pages.Register
import Evergreen.V4.Pages.Settings


type Model
    = Redirecting_
    | Cards Evergreen.V4.Gen.Params.Cards.Params Evergreen.V4.Pages.Cards.Model
    | Home_ Evergreen.V4.Gen.Params.Home_.Params Evergreen.V4.Pages.Home_.Model
    | Login Evergreen.V4.Gen.Params.Login.Params Evergreen.V4.Pages.Login.Model
    | NotFound Evergreen.V4.Gen.Params.NotFound.Params
    | Register Evergreen.V4.Gen.Params.Register.Params Evergreen.V4.Pages.Register.Model
    | Settings Evergreen.V4.Gen.Params.Settings.Params Evergreen.V4.Pages.Settings.Model
    | Profile__Username_ Evergreen.V4.Gen.Params.Profile.Username_.Params Evergreen.V4.Pages.Profile.Username_.Model
