module Evergreen.V25.OAuth.AuthorizationCode exposing (..)

import Evergreen.V25.OAuth


type alias AuthorizationError =
    { error : Evergreen.V25.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V25.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
