module Evergreen.V41.Gen.Model exposing (..)

import Evergreen.V41.Gen.Params.Admin
import Evergreen.V41.Gen.Params.Cards
import Evergreen.V41.Gen.Params.Catalog
import Evergreen.V41.Gen.Params.Home_
import Evergreen.V41.Gen.Params.Login
import Evergreen.V41.Gen.Params.Login.Provider_.Callback
import Evergreen.V41.Gen.Params.NotFound
import Evergreen.V41.Gen.Params.Stories.MathJaxDemo
import Evergreen.V41.Gen.Params.Study
import Evergreen.V41.Pages.Admin
import Evergreen.V41.Pages.Cards
import Evergreen.V41.Pages.Catalog
import Evergreen.V41.Pages.Home_
import Evergreen.V41.Pages.Login
import Evergreen.V41.Pages.Login.Provider_.Callback
import Evergreen.V41.Pages.NotFound
import Evergreen.V41.Pages.Stories.MathJaxDemo
import Evergreen.V41.Pages.Study


type Model
    = Redirecting_
    | Admin Evergreen.V41.Gen.Params.Admin.Params Evergreen.V41.Pages.Admin.Model
    | Cards Evergreen.V41.Gen.Params.Cards.Params Evergreen.V41.Pages.Cards.Model
    | Catalog Evergreen.V41.Gen.Params.Catalog.Params Evergreen.V41.Pages.Catalog.Model
    | Home_ Evergreen.V41.Gen.Params.Home_.Params Evergreen.V41.Pages.Home_.Model
    | Login Evergreen.V41.Gen.Params.Login.Params Evergreen.V41.Pages.Login.Model
    | NotFound Evergreen.V41.Gen.Params.NotFound.Params Evergreen.V41.Pages.NotFound.Model
    | Study Evergreen.V41.Gen.Params.Study.Params Evergreen.V41.Pages.Study.Model
    | Login__Provider___Callback Evergreen.V41.Gen.Params.Login.Provider_.Callback.Params Evergreen.V41.Pages.Login.Provider_.Callback.Model
    | Stories__MathJaxDemo Evergreen.V41.Gen.Params.Stories.MathJaxDemo.Params Evergreen.V41.Pages.Stories.MathJaxDemo.Model
