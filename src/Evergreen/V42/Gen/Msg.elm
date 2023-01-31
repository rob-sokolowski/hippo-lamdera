module Evergreen.V42.Gen.Msg exposing (..)

import Evergreen.V42.Pages.Admin
import Evergreen.V42.Pages.Cards
import Evergreen.V42.Pages.Catalog
import Evergreen.V42.Pages.Home_
import Evergreen.V42.Pages.Login
import Evergreen.V42.Pages.Login.Provider_.Callback
import Evergreen.V42.Pages.NotFound
import Evergreen.V42.Pages.Stories.MathJaxDemo
import Evergreen.V42.Pages.Study


type Msg
    = Admin Evergreen.V42.Pages.Admin.Msg
    | Cards Evergreen.V42.Pages.Cards.Msg
    | Catalog Evergreen.V42.Pages.Catalog.Msg
    | Home_ Evergreen.V42.Pages.Home_.Msg
    | Login Evergreen.V42.Pages.Login.Msg
    | NotFound Evergreen.V42.Pages.NotFound.Msg
    | Study Evergreen.V42.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V42.Pages.Login.Provider_.Callback.Msg
    | Stories__MathJaxDemo Evergreen.V42.Pages.Stories.MathJaxDemo.Msg
