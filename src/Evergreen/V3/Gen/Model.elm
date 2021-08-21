module Evergreen.V3.Gen.Model exposing (..)

import Evergreen.V3.Gen.Params.Home_
import Evergreen.V3.Gen.Params.Login
import Evergreen.V3.Gen.Params.NotFound
import Evergreen.V3.Gen.Params.Profile.Username_
import Evergreen.V3.Gen.Params.Register
import Evergreen.V3.Gen.Params.Settings
import Evergreen.V3.Pages.Home_
import Evergreen.V3.Pages.Login
import Evergreen.V3.Pages.Profile.Username_
import Evergreen.V3.Pages.Register
import Evergreen.V3.Pages.Settings


type Model
    = Redirecting_
    | Home_ Evergreen.V3.Gen.Params.Home_.Params Evergreen.V3.Pages.Home_.Model
    | Login Evergreen.V3.Gen.Params.Login.Params Evergreen.V3.Pages.Login.Model
    | NotFound Evergreen.V3.Gen.Params.NotFound.Params
    | Register Evergreen.V3.Gen.Params.Register.Params Evergreen.V3.Pages.Register.Model
    | Settings Evergreen.V3.Gen.Params.Settings.Params Evergreen.V3.Pages.Settings.Model
    | Profile__Username_ Evergreen.V3.Gen.Params.Profile.Username_.Params Evergreen.V3.Pages.Profile.Username_.Model
