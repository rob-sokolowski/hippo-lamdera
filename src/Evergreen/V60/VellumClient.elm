module Evergreen.V60.VellumClient exposing (..)


type alias PingResponse =
    { message : String
    }


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


type alias VellumResponseParsingError =
    String


type alias CandidateCard =
    { question : String
    , answer : String
    }
