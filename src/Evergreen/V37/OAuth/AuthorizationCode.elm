module Evergreen.V37.OAuth.AuthorizationCode exposing (..)

import Evergreen.V37.OAuth


type alias AuthorizationError =
    { error : Evergreen.V37.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V37.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
