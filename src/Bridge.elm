module Bridge exposing (..)

import Api.Article.Filters exposing (Filters)
import Api.User exposing (User)
import Lamdera


sendToBackend =
    Lamdera.sendToBackend


type ToBackend
    = SignedOut User
      -- Req/resp paired messages
    | GetTags_Home_
    | ArticleList_Home_ { filters : Filters, page : Int }
    | ArticleFeed_Home_ { page : Int }
    | ArticleList_Username_ { filters : Filters, page : Int }
    | ArticleGet_Editor__ArticleSlug_ { slug : String }
    | ArticleGet_Article__Slug_ { slug : String }
    | ArticleCreate_Editor
        { article :
            { title : String, description : String, body : String, tags : List String }
        }
    | ArticleUpdate_Editor__ArticleSlug_
        { slug : String
        , updates :
            { title : String, description : String, body : String, tags : List String }
        }
    | ArticleDelete_Article__Slug_ { slug : String }
    

    | ProfileGet_Profile__Username_ { username : String }
    
    
    
    
    | UserAuthentication_Login { params : { email : String, password : String } }
    | UserRegistration_Register { params : { username : String, email : String, password : String } }
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
