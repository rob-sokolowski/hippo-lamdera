module Evergreen.V41.Gen.Msg exposing (..)

import Evergreen.V41.Pages.Admin
import Evergreen.V41.Pages.Cards
import Evergreen.V41.Pages.Catalog
import Evergreen.V41.Pages.Home_
import Evergreen.V41.Pages.Login
import Evergreen.V41.Pages.Login.Provider_.Callback
import Evergreen.V41.Pages.NotFound
import Evergreen.V41.Pages.Stories.MathJaxDemo
import Evergreen.V41.Pages.Study


type Msg
    = Admin Evergreen.V41.Pages.Admin.Msg
    | Cards Evergreen.V41.Pages.Cards.Msg
    | Catalog Evergreen.V41.Pages.Catalog.Msg
    | Home_ Evergreen.V41.Pages.Home_.Msg
    | Login Evergreen.V41.Pages.Login.Msg
    | NotFound Evergreen.V41.Pages.NotFound.Msg
    | Study Evergreen.V41.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V41.Pages.Login.Provider_.Callback.Msg
    | Stories__MathJaxDemo Evergreen.V41.Pages.Stories.MathJaxDemo.Msg
