module Evergreen.V1.Gen.Msg exposing (..)

import Evergreen.V1.Pages.Article.Slug_
import Evergreen.V1.Pages.Editor
import Evergreen.V1.Pages.Editor.ArticleSlug_
import Evergreen.V1.Pages.Home_
import Evergreen.V1.Pages.Login
import Evergreen.V1.Pages.Profile.Username_
import Evergreen.V1.Pages.Register
import Evergreen.V1.Pages.Settings


type Msg
    = Editor Evergreen.V1.Pages.Editor.Msg
    | Home_ Evergreen.V1.Pages.Home_.Msg
    | Login Evergreen.V1.Pages.Login.Msg
    | Register Evergreen.V1.Pages.Register.Msg
    | Settings Evergreen.V1.Pages.Settings.Msg
    | Article__Slug_ Evergreen.V1.Pages.Article.Slug_.Msg
    | Editor__ArticleSlug_ Evergreen.V1.Pages.Editor.ArticleSlug_.Msg
    | Profile__Username_ Evergreen.V1.Pages.Profile.Username_.Msg
