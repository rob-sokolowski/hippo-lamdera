module Components.NotFound exposing (view)

import Element as E exposing (..)


view : Element msg
view =
    el [ centerX, centerY ] <| text "404"
