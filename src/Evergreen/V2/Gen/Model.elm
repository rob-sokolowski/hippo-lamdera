module Evergreen.V2.Gen.Model exposing (..)

import Evergreen.V2.Gen.Params.Article.Slug_
import Evergreen.V2.Gen.Params.Editor
import Evergreen.V2.Gen.Params.Editor.ArticleSlug_
import Evergreen.V2.Gen.Params.Home_
import Evergreen.V2.Gen.Params.Login
import Evergreen.V2.Gen.Params.NotFound
import Evergreen.V2.Gen.Params.Profile.Username_
import Evergreen.V2.Gen.Params.Register
import Evergreen.V2.Gen.Params.Settings
import Evergreen.V2.Pages.Article.Slug_
import Evergreen.V2.Pages.Editor
import Evergreen.V2.Pages.Editor.ArticleSlug_
import Evergreen.V2.Pages.Home_
import Evergreen.V2.Pages.Login
import Evergreen.V2.Pages.Profile.Username_
import Evergreen.V2.Pages.Register
import Evergreen.V2.Pages.Settings


type Model
    = Redirecting_
    | Editor Evergreen.V2.Gen.Params.Editor.Params Evergreen.V2.Pages.Editor.Model
    | Home_ Evergreen.V2.Gen.Params.Home_.Params Evergreen.V2.Pages.Home_.Model
    | Login Evergreen.V2.Gen.Params.Login.Params Evergreen.V2.Pages.Login.Model
    | NotFound Evergreen.V2.Gen.Params.NotFound.Params
    | Register Evergreen.V2.Gen.Params.Register.Params Evergreen.V2.Pages.Register.Model
    | Settings Evergreen.V2.Gen.Params.Settings.Params Evergreen.V2.Pages.Settings.Model
    | Article__Slug_ Evergreen.V2.Gen.Params.Article.Slug_.Params Evergreen.V2.Pages.Article.Slug_.Model
    | Editor__ArticleSlug_ Evergreen.V2.Gen.Params.Editor.ArticleSlug_.Params Evergreen.V2.Pages.Editor.ArticleSlug_.Model
    | Profile__Username_ Evergreen.V2.Gen.Params.Profile.Username_.Params Evergreen.V2.Pages.Profile.Username_.Model
