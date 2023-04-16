module Evergreen.V49.OAuth.AuthorizationCode exposing (..)

import Evergreen.V49.OAuth


type alias AuthorizationError =
    { error : Evergreen.V49.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V49.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
