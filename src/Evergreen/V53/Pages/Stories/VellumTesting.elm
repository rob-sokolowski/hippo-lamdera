module Evergreen.V53.Pages.Stories.VellumTesting exposing (..)

import Evergreen.V53.VellumClient
import Http


type alias Model =
    { nCards : Int
    , title : String
    , author : String
    , response : Evergreen.V53.VellumClient.RemoteData Http.Error Evergreen.V53.VellumClient.VellumResponse
    , pingResponse : Evergreen.V53.VellumClient.RemoteData Http.Error Evergreen.V53.VellumClient.PingResponse
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
    | Got_PingResponse (Result Http.Error Evergreen.V53.VellumClient.PingResponse)
    | Got_VellumResponse (Result Http.Error Evergreen.V53.VellumClient.VellumResponse)
