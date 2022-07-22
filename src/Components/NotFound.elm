module Components.NotFound exposing (view)

import Element as E exposing (..)
import Html exposing (..)
import Html.Attributes exposing (class, href)


view : Element msg
view =
    E.text "404 error"
