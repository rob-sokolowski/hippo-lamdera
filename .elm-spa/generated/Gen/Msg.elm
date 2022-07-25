module Gen.Msg exposing (Msg(..))

import Gen.Params.Cards
import Gen.Params.Catalog
import Gen.Params.Home_
import Gen.Params.Login
import Gen.Params.NotFound
import Gen.Params.Register
import Gen.Params.Study
import Gen.Params.Login.GoogleOauth.Callback
import Pages.Cards
import Pages.Catalog
import Pages.Home_
import Pages.Login
import Pages.NotFound
import Pages.Register
import Pages.Study
import Pages.Login.GoogleOauth.Callback


type Msg
    = Cards Pages.Cards.Msg
    | Catalog Pages.Catalog.Msg
    | Home_ Pages.Home_.Msg
    | Login Pages.Login.Msg
    | NotFound Pages.NotFound.Msg
    | Register Pages.Register.Msg
    | Study Pages.Study.Msg
    | Login__GoogleOauth__Callback Pages.Login.GoogleOauth.Callback.Msg

