module Evergreen.V6.Gen.Model exposing (..)

import Evergreen.V6.Gen.Params.Cards
import Evergreen.V6.Gen.Params.Home_
import Evergreen.V6.Gen.Params.Login
import Evergreen.V6.Gen.Params.NotFound
import Evergreen.V6.Gen.Params.Profile.Username_
import Evergreen.V6.Gen.Params.Register
import Evergreen.V6.Gen.Params.Settings
import Evergreen.V6.Gen.Params.Study
import Evergreen.V6.Pages.Cards
import Evergreen.V6.Pages.Home_
import Evergreen.V6.Pages.Login
import Evergreen.V6.Pages.Profile.Username_
import Evergreen.V6.Pages.Register
import Evergreen.V6.Pages.Settings
import Evergreen.V6.Pages.Study


type Model
    = Redirecting_
    | Cards Evergreen.V6.Gen.Params.Cards.Params Evergreen.V6.Pages.Cards.Model
    | Home_ Evergreen.V6.Gen.Params.Home_.Params Evergreen.V6.Pages.Home_.Model
    | Login Evergreen.V6.Gen.Params.Login.Params Evergreen.V6.Pages.Login.Model
    | NotFound Evergreen.V6.Gen.Params.NotFound.Params
    | Register Evergreen.V6.Gen.Params.Register.Params Evergreen.V6.Pages.Register.Model
    | Settings Evergreen.V6.Gen.Params.Settings.Params Evergreen.V6.Pages.Settings.Model
    | Study Evergreen.V6.Gen.Params.Study.Params Evergreen.V6.Pages.Study.Model
    | Profile__Username_ Evergreen.V6.Gen.Params.Profile.Username_.Params Evergreen.V6.Pages.Profile.Username_.Model