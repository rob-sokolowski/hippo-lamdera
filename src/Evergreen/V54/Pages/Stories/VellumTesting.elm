module Evergreen.V54.Pages.Stories.VellumTesting exposing (..)

import Evergreen.V54.VellumClient
import Http


type alias Model =
    { nCards : Int
    , title : String
    , author : String
    , response : Evergreen.V54.VellumClient.RemoteData Http.Error Evergreen.V54.VellumClient.VellumResponse
    , vellumText : Maybe String
    , pingResponse : Evergreen.V54.VellumClient.RemoteData Http.Error Evergreen.V54.VellumClient.PingResponse
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
    | Got_PingResponse (Result Http.Error Evergreen.V54.VellumClient.PingResponse)
    | Got_VellumResponse (Result Http.Error Evergreen.V54.VellumClient.VellumResponse)
