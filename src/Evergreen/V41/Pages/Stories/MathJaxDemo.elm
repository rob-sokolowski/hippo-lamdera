module Evergreen.V41.Pages.Stories.MathJaxDemo exposing (..)

import Evergreen.V41.Scripta.API


type alias Model =
    { counter : Int
    }


type Msg
    = Render Evergreen.V41.Scripta.API.Msg
