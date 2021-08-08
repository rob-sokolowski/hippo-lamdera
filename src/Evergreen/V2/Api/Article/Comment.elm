module Evergreen.V2.Api.Article.Comment exposing (..)

import Evergreen.V2.Api.Profile
import Time


type alias Comment =
    { id : Int
    , createdAt : Time.Posix
    , updatedAt : Time.Posix
    , body : String
    , author : Evergreen.V2.Api.Profile.Profile
    }
