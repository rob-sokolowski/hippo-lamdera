module Evergreen.V52.Pages.Stories.VellumTesting exposing (..)

import Evergreen.V52.VellumClient
import Http


type alias Model =
    { nCards : Int
    , title : String
    , author : String
    , response : Evergreen.V52.VellumClient.RemoteData Http.Error Evergreen.V52.VellumClient.VellumResponse
    }


type FormField
    = NumCards
    | Title
    | Author


type Msg
    = UpdatedFormField FormField String
    | UpdatedSlider Float
    | UserPressedVellumAssist
    | Got_VellumResponse (Result Http.Error Evergreen.V52.VellumClient.VellumResponse)
