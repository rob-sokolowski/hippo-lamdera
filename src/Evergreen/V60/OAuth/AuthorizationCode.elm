module Evergreen.V60.OAuth.AuthorizationCode exposing (..)

import Evergreen.V60.OAuth


type alias AuthorizationError =
    { error : Evergreen.V60.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V60.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
