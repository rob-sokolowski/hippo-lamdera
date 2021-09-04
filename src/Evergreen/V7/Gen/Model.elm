module Evergreen.V7.Gen.Model exposing (..)

import Evergreen.V7.Gen.Params.Cards
import Evergreen.V7.Gen.Params.Home_
import Evergreen.V7.Gen.Params.Login
import Evergreen.V7.Gen.Params.NotFound
import Evergreen.V7.Gen.Params.Profile.Username_
import Evergreen.V7.Gen.Params.Register
import Evergreen.V7.Gen.Params.Settings
import Evergreen.V7.Gen.Params.Study
import Evergreen.V7.Pages.Cards
import Evergreen.V7.Pages.Home_
import Evergreen.V7.Pages.Login
import Evergreen.V7.Pages.Profile.Username_
import Evergreen.V7.Pages.Register
import Evergreen.V7.Pages.Settings
import Evergreen.V7.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V7.Gen.Params.Cards.Params Evergreen.V7.Pages.Cards.Model
    | Home_ Evergreen.V7.Gen.Params.Home_.Params Evergreen.V7.Pages.Home_.Model
    | Login Evergreen.V7.Gen.Params.Login.Params Evergreen.V7.Pages.Login.Model
    | NotFound Evergreen.V7.Gen.Params.NotFound.Params
    | Register Evergreen.V7.Gen.Params.Register.Params Evergreen.V7.Pages.Register.Model
    | Settings Evergreen.V7.Gen.Params.Settings.Params Evergreen.V7.Pages.Settings.Model
    | Study Evergreen.V7.Gen.Params.Study.Params Evergreen.V7.Pages.Study.Model
    | Profile__Username_ Evergreen.V7.Gen.Params.Profile.Username_.Params Evergreen.V7.Pages.Profile.Username_.Model