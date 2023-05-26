module Evergreen.V55.Pages.Stories.VellumTesting exposing (..)

import Evergreen.V55.VellumClient
import Http


type alias Model =
    { nCards : Int
    , title : String
    , author : String
    , response : Evergreen.V55.VellumClient.RemoteData Http.Error Evergreen.V55.VellumClient.VellumResponse
    , vellumText : Maybe String
    , vellumParsedCards : Maybe (Result Evergreen.V55.VellumClient.VellumResponseParsingError (List Evergreen.V55.VellumClient.CandidateCard))
    , pingResponse : Evergreen.V55.VellumClient.RemoteData Http.Error Evergreen.V55.VellumClient.PingResponse
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
    | Got_PingResponse (Result Http.Error Evergreen.V55.VellumClient.PingResponse)
    | Got_VellumResponse (Result Http.Error Evergreen.V55.VellumClient.VellumResponse)
