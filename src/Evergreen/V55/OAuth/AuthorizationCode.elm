module Evergreen.V55.OAuth.AuthorizationCode exposing (..)

import Evergreen.V55.OAuth


type alias AuthorizationError =
    { error : Evergreen.V55.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    , state : Maybe String
    }


type alias AuthenticationError =
    { error : Evergreen.V55.OAuth.ErrorCode
    , errorDescription : Maybe String
    , errorUri : Maybe String
    }
