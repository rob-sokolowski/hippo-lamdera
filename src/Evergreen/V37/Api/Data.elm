module Evergreen.V37.Api.Data exposing (..)


type Data value
    = NotAsked
    | Loading
    | Failure (List String)
    | Success value
