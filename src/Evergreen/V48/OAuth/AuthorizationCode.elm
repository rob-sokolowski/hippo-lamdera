module Evergreen.V48.OAuth.AuthorizationCode exposing (..)

import Evergreen.V48.OAuth


type alias AuthorizationError =
    { error : Evergreen.V48.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V48.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
