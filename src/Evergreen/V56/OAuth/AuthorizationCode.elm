module Evergreen.V56.OAuth.AuthorizationCode exposing (..)

import Evergreen.V56.OAuth


type alias AuthorizationError =
    { error : Evergreen.V56.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V56.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
