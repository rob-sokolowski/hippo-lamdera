module Evergreen.V54.VellumClient exposing (..)


type alias VellumResponseResultsObjectDataCompletionsObject =
    { externalId : ()
    , finishReason : String
    , id : String
    , logprobs : ()
    , modelVersionId : String
    , text : String
    }


type alias VellumResponseResultsObjectData =
    { completions : List VellumResponseResultsObjectDataCompletionsObject
    }


type alias VellumResponseResultsObject =
    { data : VellumResponseResultsObjectData
    , error : ()
    }


type alias VellumResponse =
    { results : List VellumResponseResultsObject
    }


type RemoteData err a
    = NotAsked
    | Loading
    | Success a
    | Failure err


type alias PingResponse =
    { message : String
    }
