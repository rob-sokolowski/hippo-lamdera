module Evergreen.V1.Api.Article.Comment exposing (..)

import Evergreen.V1.Api.Profile
import Time


type alias Comment =
    { id : Int
    , createdAt : Time.Posix
    , updatedAt : Time.Posix
    , body : String
    , author : Evergreen.V1.Api.Profile.Profile
    }
