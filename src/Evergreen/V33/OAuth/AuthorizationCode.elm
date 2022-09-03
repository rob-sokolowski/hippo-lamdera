module Evergreen.V33.OAuth.AuthorizationCode exposing (..)

import Evergreen.V33.OAuth


type alias AuthorizationError =
    { error : Evergreen.V33.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V33.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
