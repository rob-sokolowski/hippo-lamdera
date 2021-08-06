module Evergreen.V1.Gen.Model exposing (..)

import Evergreen.V1.Gen.Params.Article.Slug_
import Evergreen.V1.Gen.Params.Editor
import Evergreen.V1.Gen.Params.Editor.ArticleSlug_
import Evergreen.V1.Gen.Params.Home_
import Evergreen.V1.Gen.Params.Login
import Evergreen.V1.Gen.Params.NotFound
import Evergreen.V1.Gen.Params.Profile.Username_
import Evergreen.V1.Gen.Params.Register
import Evergreen.V1.Gen.Params.Settings
import Evergreen.V1.Pages.Article.Slug_
import Evergreen.V1.Pages.Editor
import Evergreen.V1.Pages.Editor.ArticleSlug_
import Evergreen.V1.Pages.Home_
import Evergreen.V1.Pages.Login
import Evergreen.V1.Pages.Profile.Username_
import Evergreen.V1.Pages.Register
import Evergreen.V1.Pages.Settings


type Model
    = Redirecting_
    | Editor Evergreen.V1.Gen.Params.Editor.Params Evergreen.V1.Pages.Editor.Model
    | Home_ Evergreen.V1.Gen.Params.Home_.Params Evergreen.V1.Pages.Home_.Model
    | Login Evergreen.V1.Gen.Params.Login.Params Evergreen.V1.Pages.Login.Model
    | NotFound Evergreen.V1.Gen.Params.NotFound.Params
    | Register Evergreen.V1.Gen.Params.Register.Params Evergreen.V1.Pages.Register.Model
    | Settings Evergreen.V1.Gen.Params.Settings.Params Evergreen.V1.Pages.Settings.Model
    | Article__Slug_ Evergreen.V1.Gen.Params.Article.Slug_.Params Evergreen.V1.Pages.Article.Slug_.Model
    | Editor__ArticleSlug_ Evergreen.V1.Gen.Params.Editor.ArticleSlug_.Params Evergreen.V1.Pages.Editor.ArticleSlug_.Model
    | Profile__Username_ Evergreen.V1.Gen.Params.Profile.Username_.Params Evergreen.V1.Pages.Profile.Username_.Model