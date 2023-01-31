module Evergreen.V41.OAuth.AuthorizationCode exposing (..)

import Evergreen.V41.OAuth


type alias AuthorizationError =
    { error : Evergreen.V41.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V41.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
