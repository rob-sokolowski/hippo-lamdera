module Evergreen.V5.Gen.Model exposing (..)

import Evergreen.V5.Gen.Params.Cards
import Evergreen.V5.Gen.Params.Home_
import Evergreen.V5.Gen.Params.Login
import Evergreen.V5.Gen.Params.NotFound
import Evergreen.V5.Gen.Params.Profile.Username_
import Evergreen.V5.Gen.Params.Register
import Evergreen.V5.Gen.Params.Settings
import Evergreen.V5.Gen.Params.Study
import Evergreen.V5.Pages.Cards
import Evergreen.V5.Pages.Home_
import Evergreen.V5.Pages.Login
import Evergreen.V5.Pages.Profile.Username_
import Evergreen.V5.Pages.Register
import Evergreen.V5.Pages.Settings
import Evergreen.V5.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V5.Gen.Params.Cards.Params Evergreen.V5.Pages.Cards.Model
    | Home_ Evergreen.V5.Gen.Params.Home_.Params Evergreen.V5.Pages.Home_.Model
    | Login Evergreen.V5.Gen.Params.Login.Params Evergreen.V5.Pages.Login.Model
    | NotFound Evergreen.V5.Gen.Params.NotFound.Params
    | Register Evergreen.V5.Gen.Params.Register.Params Evergreen.V5.Pages.Register.Model
    | Settings Evergreen.V5.Gen.Params.Settings.Params Evergreen.V5.Pages.Settings.Model
    | Study Evergreen.V5.Gen.Params.Study.Params Evergreen.V5.Pages.Study.Model
    | Profile__Username_ Evergreen.V5.Gen.Params.Profile.Username_.Params Evergreen.V5.Pages.Profile.Username_.Model
