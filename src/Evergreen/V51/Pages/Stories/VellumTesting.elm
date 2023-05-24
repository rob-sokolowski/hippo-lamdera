module Evergreen.V51.Pages.Stories.VellumTesting exposing (..)

import Evergreen.V51.VellumClient
import Http


type alias Model =
    { nCards : Int
    , title : String
    , author : String
    , response : Evergreen.V51.VellumClient.RemoteData Http.Error Evergreen.V51.VellumClient.VellumResponse
    }


type FormField
    = NumCards
    | Title
    | Author


type Msg
    = UpdatedFormField FormField String
    | UpdatedSlider Float
    | UserPressedVellumAssist
    | Got_VellumResponse (Result Http.Error Evergreen.V51.VellumClient.VellumResponse)
