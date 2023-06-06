module Evergreen.V56.Pages.Stories.VellumTesting exposing (..)

import Evergreen.V56.VellumClient
import Http


type alias Model =
    { nCards : Int
    , title : String
    , author : String
    , response : Evergreen.V56.VellumClient.RemoteData Http.Error Evergreen.V56.VellumClient.VellumResponse
    , vellumText : Maybe String
    , vellumParsedCards : Maybe (Result Evergreen.V56.VellumClient.VellumResponseParsingError (List Evergreen.V56.VellumClient.CandidateCard))
    , pingResponse : Evergreen.V56.VellumClient.RemoteData Http.Error Evergreen.V56.VellumClient.PingResponse
    }


type FormField
    = NumCards
    | Title
    | Author


type Msg
    = UpdatedFormField FormField String
    | UpdatedSlider Float
    | UserPressedVellumAssist
    | UserPressedPing
    | Got_PingResponse (Result Http.Error Evergreen.V56.VellumClient.PingResponse)
    | Got_VellumResponse (Result Http.Error Evergreen.V56.VellumClient.VellumResponse)
