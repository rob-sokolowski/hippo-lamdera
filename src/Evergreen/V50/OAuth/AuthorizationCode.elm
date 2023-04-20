module Evergreen.V50.OAuth.AuthorizationCode exposing (..)

import Evergreen.V50.OAuth


type alias AuthorizationError =
    { error : Evergreen.V50.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V50.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
