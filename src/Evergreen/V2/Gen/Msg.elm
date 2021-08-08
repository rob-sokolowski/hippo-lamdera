module Evergreen.V2.Gen.Msg exposing (..)

import Evergreen.V2.Pages.Article.Slug_
import Evergreen.V2.Pages.Editor
import Evergreen.V2.Pages.Editor.ArticleSlug_
import Evergreen.V2.Pages.Home_
import Evergreen.V2.Pages.Login
import Evergreen.V2.Pages.Profile.Username_
import Evergreen.V2.Pages.Register
import Evergreen.V2.Pages.Settings


type Msg
    = Editor Evergreen.V2.Pages.Editor.Msg
    | Home_ Evergreen.V2.Pages.Home_.Msg
    | Login Evergreen.V2.Pages.Login.Msg
    | Register Evergreen.V2.Pages.Register.Msg
    | Settings Evergreen.V2.Pages.Settings.Msg
    | Article__Slug_ Evergreen.V2.Pages.Article.Slug_.Msg
    | Editor__ArticleSlug_ Evergreen.V2.Pages.Editor.ArticleSlug_.Msg
    | Profile__Username_ Evergreen.V2.Pages.Profile.Username_.Msg
