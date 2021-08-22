module Evergreen.V4.Api.Profile exposing (..)


type alias Profile =
    { username : String
    , bio : Maybe String
    , image : String
    , following : Bool
    }
