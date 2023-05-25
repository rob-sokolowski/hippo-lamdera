module Evergreen.V53.OAuth.AuthorizationCode exposing (..)

import Evergreen.V53.OAuth


type alias AuthorizationError =
    { error : Evergreen.V53.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V53.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
