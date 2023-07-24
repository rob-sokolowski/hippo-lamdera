module VellumClient exposing
    ( CandidateCard
    , PingResponse
    , RemoteData(..)
    , VellumInputValues
    , VellumResponse
    , VellumResponseParsingError
    , extractFlashcardText
    , fetchSummaryFlashCards
    , pingServer
    , runParser
    )

import Http
import Json.Decode as JD
import Json.Encode as JE
import Parser as P exposing ((|.), (|=))


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
    "https://api.robsoko.tech"


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
-- begin region: api private


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



-- end region: api private
-- begin region: parser public


type alias CandidateCard =
    { question : String
    , answer : String
    }


type alias VellumResponseParsingError =
    String


runParser : String -> Result VellumResponseParsingError (List CandidateCard)
runParser text =
    case P.run cards text of
        Ok cards_ ->
            Ok cards_

        Err _ ->
            Err "Could not parse Vellum response"



-- end region: parser public
-- begin region: parser private


questionStartTag : P.Parser ()
questionStartTag =
    P.succeed ()
        |. P.symbol "<question>"


questionEndTag : P.Parser ()
questionEndTag =
    P.succeed ()
        |. P.symbol "</question>"


bodyText : P.Parser String
bodyText =
    P.getChompedString (P.chompWhile (\char -> char /= '<'))


answerStartTag : P.Parser ()
answerStartTag =
    P.succeed ()
        |. P.symbol "<answer>"


answerEndTag : P.Parser ()
answerEndTag =
    P.succeed ()
        |. P.symbol "</answer>"


card : P.Parser CandidateCard
card =
    P.succeed CandidateCard
        |. P.spaces
        |. questionStartTag
        |. P.spaces
        |= bodyText
        |. P.spaces
        |. questionEndTag
        |. P.spaces
        |. answerStartTag
        |. P.spaces
        |= bodyText
        |. P.spaces
        |. answerEndTag
        |. P.spaces


cards : P.Parser (List CandidateCard)
cards =
    P.loop [] cardsHelp


cardsHelp : List CandidateCard -> P.Parser (P.Step (List CandidateCard) (List CandidateCard))
cardsHelp revCards =
    P.oneOf
        [ P.succeed (\card_ -> P.Loop (card_ :: revCards))
            |= card
            |. P.spaces
        , P.succeed ()
            |> P.map (\_ -> P.Done (List.reverse revCards))
        ]



-- end region: parser private
