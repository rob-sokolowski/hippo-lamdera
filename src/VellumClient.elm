module VellumClient exposing (PingResponse, RemoteData(..), VellumInputValues, VellumResponse, extractFlashcardText, fetchSummaryFlashCards, pingServer)

import Http
import Json.Decode as JD
import Json.Encode as JE
import Parser exposing ((|.), (|=), Parser, chompWhile, getChompedString, succeed, symbol)


type RemoteData err a
    = NotAsked
    | Loading
    | Success a
    | Failure err



-- begin region: client - public


host : String
host =
    -- This is a CORS proxy that allows us to make requests to the Vellum API from the browser
    -- This is necessary since an API key header is expected by vellum, and we don't want to expose that key to the client
    -- That header is injected by the proxy server
    "https://cors-proxy.robsoko.tech"


type alias VellumResponse =
    { results : List VellumResponseResultsObject
    }


type alias VellumInputValues =
    { nCards : Int
    , title : String
    , author : String
    }


type alias PingResponse =
    { message : String
    }


extractFlashcardText : VellumResponse -> List String
extractFlashcardText response =
    List.concatMap
        (\result -> List.map (\c -> c.text) result.data.completions)
        response.results


pingServer : Float -> (Result Http.Error PingResponse -> msg) -> Cmd msg
pingServer timeoutMs onResponse =
    let
        pingResponseDecoder : JD.Decoder PingResponse
        pingResponseDecoder =
            JD.map PingResponse
                (JD.field "message" JD.string)
    in
    Http.request
        { method = "GET"
        , headers = []
        , url = host ++ "/ping"
        , body = Http.emptyBody
        , expect = Http.expectJson onResponse pingResponseDecoder
        , timeout = Just timeoutMs
        , tracker = Nothing
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
            ]
        , url = host ++ "/vellum-ai"
        , body = Http.jsonBody encodedVellumRequest
        , expect = Http.expectJson onResponse vellumResponseDecoder
        , timeout = 60 * 1000 |> Just
        , tracker = Nothing
        }



-- end region: client - public
-- begin region: parser


questionStartTag : Parser ()
questionStartTag =
    succeed ()
        |. symbol "<question>"


questionEndTag : Parser ()
questionEndTag =
    succeed ()
        |. symbol "</question>"


bodyText : Parser String
bodyText =
    getChompedString (chompWhile (\char -> char /= '<'))


answerStartTag : Parser ()


answerstartTag =
    succeed ()
        |. symbol "<answer>"


answerEndTag : Parser ()
answerEndTag =
    succeed ()
        |. symbol "</answer>"


candidateCardParser : Parser CandidateCard
candidateCardParser =
    succeed CandidateCard
        |. questionStartTag
        |= bodyText
        |. questionEndTag
        |. answerstartTag
        |= bodyText
        |. answerEndTag


type alias CandidateCard =
    { question : String
    , answer : String
    }



-- end region: parser
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
