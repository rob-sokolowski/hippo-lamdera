module Evergreen.V42.OAuth.AuthorizationCode exposing (..)

import Evergreen.V42.OAuth


type alias AuthorizationError =
    { error : Evergreen.V42.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V42.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
