module Evergreen.V60.Pages.Stories.VellumTesting exposing (..)

import Evergreen.V60.VellumClient
import Http


type FormField
    = NumCards
    | Title
    | Author


type Msg
    = UpdatedFormField FormField String
    | UpdatedSlider Float
    | UserPressedVellumAssist
    | UserPressedPing
    | Got_PingResponse (Result Http.Error Evergreen.V60.VellumClient.PingResponse)
    | Got_VellumResponse (Result Http.Error Evergreen.V60.VellumClient.VellumResponse)


type alias Model =
    { nCards : Int
    , title : String
    , author : String
    , response : Evergreen.V60.VellumClient.RemoteData Http.Error Evergreen.V60.VellumClient.VellumResponse
    , vellumText : Maybe String
    , vellumParsedCards : Maybe (Result Evergreen.V60.VellumClient.VellumResponseParsingError (List Evergreen.V60.VellumClient.CandidateCard))
    , pingResponse : Evergreen.V60.VellumClient.RemoteData Http.Error Evergreen.V60.VellumClient.PingResponse
    }
