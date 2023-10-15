module Evergreen.V60.Gen.Msg exposing (..)

import Evergreen.V60.Pages.Admin
import Evergreen.V60.Pages.Cards
import Evergreen.V60.Pages.Catalog
import Evergreen.V60.Pages.Home_
import Evergreen.V60.Pages.Login
import Evergreen.V60.Pages.Login.Provider_.Callback
import Evergreen.V60.Pages.NotFound
import Evergreen.V60.Pages.Stories.ElmAudio
import Evergreen.V60.Pages.Stories.KatexDemo
import Evergreen.V60.Pages.Stories.VellumTesting
import Evergreen.V60.Pages.Study


type Msg
    = Admin Evergreen.V60.Pages.Admin.Msg
    | Cards Evergreen.V60.Pages.Cards.Msg
    | Catalog Evergreen.V60.Pages.Catalog.Msg
    | Home_ Evergreen.V60.Pages.Home_.Msg
    | Login Evergreen.V60.Pages.Login.Msg
    | NotFound Evergreen.V60.Pages.NotFound.Msg
    | Study Evergreen.V60.Pages.Study.Msg
    | Login__Provider___Callback Evergreen.V60.Pages.Login.Provider_.Callback.Msg
    | Stories__ElmAudio Evergreen.V60.Pages.Stories.ElmAudio.Msg
    | Stories__KatexDemo Evergreen.V60.Pages.Stories.KatexDemo.Msg
    | Stories__VellumTesting Evergreen.V60.Pages.Stories.VellumTesting.Msg
