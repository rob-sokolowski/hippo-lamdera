module Evergreen.V42.Gen.Model exposing (..)

import Evergreen.V42.Gen.Params.Admin
import Evergreen.V42.Gen.Params.Cards
import Evergreen.V42.Gen.Params.Catalog
import Evergreen.V42.Gen.Params.Home_
import Evergreen.V42.Gen.Params.Login
import Evergreen.V42.Gen.Params.Login.Provider_.Callback
import Evergreen.V42.Gen.Params.NotFound
import Evergreen.V42.Gen.Params.Stories.MathJaxDemo
import Evergreen.V42.Gen.Params.Study
import Evergreen.V42.Pages.Admin
import Evergreen.V42.Pages.Cards
import Evergreen.V42.Pages.Catalog
import Evergreen.V42.Pages.Home_
import Evergreen.V42.Pages.Login
import Evergreen.V42.Pages.Login.Provider_.Callback
import Evergreen.V42.Pages.NotFound
import Evergreen.V42.Pages.Stories.MathJaxDemo
import Evergreen.V42.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V42.Gen.Params.Admin.Params Evergreen.V42.Pages.Admin.Model
    | Cards Evergreen.V42.Gen.Params.Cards.Params Evergreen.V42.Pages.Cards.Model
    | Catalog Evergreen.V42.Gen.Params.Catalog.Params Evergreen.V42.Pages.Catalog.Model
    | Home_ Evergreen.V42.Gen.Params.Home_.Params Evergreen.V42.Pages.Home_.Model
    | Login Evergreen.V42.Gen.Params.Login.Params Evergreen.V42.Pages.Login.Model
    | NotFound Evergreen.V42.Gen.Params.NotFound.Params Evergreen.V42.Pages.NotFound.Model
    | Study Evergreen.V42.Gen.Params.Study.Params Evergreen.V42.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V42.Gen.Params.Login.Provider_.Callback.Params Evergreen.V42.Pages.Login.Provider_.Callback.Model
    | Stories__MathJaxDemo Evergreen.V42.Gen.Params.Stories.MathJaxDemo.Params Evergreen.V42.Pages.Stories.MathJaxDemo.Model
