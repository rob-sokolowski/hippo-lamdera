module VellumClient exposing (RemoteData(..), VellumInputValues, VellumResponse, fetchSummaryFlashCards)

import Config
import Http
import Json.Decode as JD
import Json.Encode as JE


type RemoteData err a
    = NotAsked
    | Loading
    | Success a
    | Failure err


url : String
url =
    "https://predict.vellum.ai/v1/generate"


type alias VellumResponse =
    { results : List VellumResponseResultsObject
    }


type alias VellumInputValues =
    { nCards : Int
    , title : String
    , author : String
    }


fetchSummaryFlashCards : VellumInputValues -> (Result Http.Error VellumResponse -> msg) -> Cmd msg
fetchSummaryFlashCards input onResponse =
    let
        vellumRequest : VellumRequest
        vellumRequest =
            { requests = [ { inputValues = input, externalIds = Nothing } ]
            , deploymentId = Nothing
            , deploymentName = "hippo-testing"
            }

        encodedVellumRequest : JE.Value
        encodedVellumRequest =
            JE.object
                [ ( "deployment_id", JE.null )
                , ( "deployment_name", JE.string vellumRequest.deploymentName )
                , ( "requests", JE.list innerRequestsEncoder vellumRequest.requests )
                ]

        innerRequestsEncoder : InnerRequest -> JE.Value
        innerRequestsEncoder req_ =
            JE.object
                [ ( "external_ids", JE.null )
                , ( "input_values", inputValueEncoder req_.inputValues )
                ]

        inputValueEncoder : VellumInputValues -> JE.Value
        inputValueEncoder inputVal =
            JE.object
                [ ( "n_cards", JE.int inputVal.nCards )
                , ( "title", JE.string inputVal.title )
                , ( "author", JE.string inputVal.author )
                ]

        vellumResponseDecoder : JD.Decoder VellumResponse
        vellumResponseDecoder =
            JD.map VellumResponse
                (JD.field "results" <| JD.list vellumResponseResultsObjectDecoder)

        vellumResponseResultsObjectDecoder : JD.Decoder VellumResponseResultsObject
        vellumResponseResultsObjectDecoder =
            JD.map2 VellumResponseResultsObject
                (JD.field "data" vellumResponseResultsObjectDataDecoder)
                (JD.field "error" <| JD.null ())

        vellumResponseResultsObjectDataDecoder : JD.Decoder VellumResponseResultsObjectData
        vellumResponseResultsObjectDataDecoder =
            JD.map VellumResponseResultsObjectData
                (JD.field "completions" <| JD.list vellumResponseResultsObjectDataCompletionsObjectDecoder)

        vellumResponseResultsObjectDataCompletionsObjectDecoder : JD.Decoder VellumResponseResultsObjectDataCompletionsObject
        vellumResponseResultsObjectDataCompletionsObjectDecoder =
            JD.map6 VellumResponseResultsObjectDataCompletionsObject
                (JD.field "external_id" <| JD.null ())
                (JD.field "finish_reason" JD.string)
                (JD.field "id" JD.string)
                (JD.field "logprobs" <| JD.null ())
                (JD.field "model_version_id" JD.string)
                (JD.field "text" JD.string)
    in
    Http.request
        { method = "POST"
        , headers =
            [ Http.header "Content-Type" "application/json"
            , Http.header "X-API-KEY" Config.vellumApiKey
            ]
        , url = url
        , body = Http.jsonBody encodedVellumRequest
        , expect = Http.expectJson onResponse vellumResponseDecoder
        , timeout = Nothing
        , tracker = Nothing
        }



-- begin region: private


type alias VellumResponseResultsObject =
    { data : VellumResponseResultsObjectData
    , error : ()
    }


type alias VellumResponseResultsObjectData =
    { completions : List VellumResponseResultsObjectDataCompletionsObject
    }


type alias VellumResponseResultsObjectDataCompletionsObject =
    { externalId : ()
    , finishReason : String
    , id : String
    , logprobs : ()
    , modelVersionId : String
    , text : String
    }


type alias InnerRequest =
    { inputValues : VellumInputValues
    , externalIds : Maybe String
    }


type alias VellumRequest =
    { requests : List InnerRequest
    , deploymentId : Maybe String
    , deploymentName : String
    }



-- end region: private
