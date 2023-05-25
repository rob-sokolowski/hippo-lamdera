module Evergreen.V52.OAuth exposing (..)


type Token
    = Bearer String


type ErrorCode
    = InvalidRequest
    | UnauthorizedClient
    | AccessDenied
    | UnsupportedResponseType
    | InvalidScope
    | ServerError
    | TemporarilyUnavailable
    | Custom String
