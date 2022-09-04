module Evergreen.V39.OAuth.AuthorizationCode exposing (..)

import Evergreen.V39.OAuth


type alias AuthorizationError =
    { error : Evergreen.V39.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V39.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
