module Evergreen.V54.OAuth.AuthorizationCode exposing (..)

import Evergreen.V54.OAuth


type alias AuthorizationError =
    { error : Evergreen.V54.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V54.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
