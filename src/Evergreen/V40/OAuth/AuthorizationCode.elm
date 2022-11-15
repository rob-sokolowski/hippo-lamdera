module Evergreen.V40.OAuth.AuthorizationCode exposing (..)

import Evergreen.V40.OAuth


type alias AuthorizationError =
    { error : Evergreen.V40.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V40.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
