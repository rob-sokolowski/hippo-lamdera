module Evergreen.V26.OAuth.AuthorizationCode exposing (..)

import Evergreen.V26.OAuth


type alias AuthorizationError =
    { error : Evergreen.V26.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V26.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
