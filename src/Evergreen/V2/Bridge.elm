module Evergreen.V2.Bridge exposing (..)

import Evergreen.V2.Api.Article.Filters
import Evergreen.V2.Api.User


type ToBackend
    = SignedOut Evergreen.V2.Api.User.User
    | GetTags_Home_
    | ArticleList_Home_
        { filters : Evergreen.V2.Api.Article.Filters.Filters
        , page : Int
        }
    | ArticleFeed_Home_
        { page : Int
        }
    | ArticleList_Username_
        { filters : Evergreen.V2.Api.Article.Filters.Filters
        , page : Int
        }
    | ArticleGet_Editor__ArticleSlug_
        { slug : String
        }
    | ArticleGet_Article__Slug_
        { slug : String
        }
    | ArticleCreate_Editor
        { article :
            { title : String
            , description : String
            , body : String
            , tags : List String
            }
        }
    | ArticleUpdate_Editor__ArticleSlug_
        { slug : String
        , updates :
            { title : String
            , description : String
            , body : String
            , tags : List String
            }
        }
    | ArticleDelete_Article__Slug_
        { slug : String
        }
    | ProfileGet_Profile__Username_
        { username : String
        }
    | UserAuthentication_Login
        { params :
            { email : String
            , password : String
            }
        }
    | UserRegistration_Register
        { params :
            { username : String
            , email : String
            , password : String
            }
        }
    | UserUpdate_Settings
        { params :
            { username : String
            , email : String
            , password : Maybe String
            , image : String
            , bio : String
            }
        }
    | NoOpToBackend
