module VellumClient exposing (RemoteData(..), VellumInputValues, VellumResponse, fetchSummaryFlashCards)

import Http


type RemoteData err a
    = NotAsked
    | Loading
    | Success VellumResponse
    | Failure Http.Error


type alias VellumInputValues =
    { nCards : Int
    , title : String
    , author : String
    , response : RemoteData Http.Error VellumResponse
    }


type alias VellumResponse =
    { text : String
    }


fetchSummaryFlashCards : VellumInputValues -> (Cmd msg -> Result Http.Error VellumResponse) -> Cmd msg
fetchSummaryFlashCards input onResponse =
    Cmd.none
