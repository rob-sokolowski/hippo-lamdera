module Evergreen.V51.OAuth.AuthorizationCode exposing (..)

import Evergreen.V51.OAuth


type alias AuthorizationError =
    { error : Evergreen.V51.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V51.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
