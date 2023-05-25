module Evergreen.V52.OAuth.AuthorizationCode exposing (..)

import Evergreen.V52.OAuth


type alias AuthorizationError =
    { error : Evergreen.V52.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V52.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
