module Evergreen.V30.OAuth.AuthorizationCode exposing (..)

import Evergreen.V30.OAuth


type alias AuthorizationError =
    { error : Evergreen.V30.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V30.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
