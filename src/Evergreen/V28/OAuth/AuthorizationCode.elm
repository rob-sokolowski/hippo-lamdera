module Evergreen.V28.OAuth.AuthorizationCode exposing (..)

import Evergreen.V28.OAuth


type alias AuthorizationError =
    { error : Evergreen.V28.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V28.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
