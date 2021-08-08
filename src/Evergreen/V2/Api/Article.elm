module Evergreen.V2.Api.Article exposing (..)

import Evergreen.V2.Api.Profile
import Time


type alias Slug =
    String


type alias Article =
    { slug : Slug
    , title : String
    , description : String
    , body : String
    , tags : List String
    , createdAt : Time.Posix
    , updatedAt : Time.Posix
    , author : Evergreen.V2.Api.Profile.Profile
    }


type alias Listing =
    { articles : List Article
    , page : Int
    , totalPages : Int
    }


type alias ArticleStore =
    { slug : Slug
    , title : String
    , description : String
    , body : String
    , tags : List String
    , createdAt : Time.Posix
    , updatedAt : Time.Posix
    , userId : Int
    }
