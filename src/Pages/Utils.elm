module Pages.Utils exposing (..)

import Api.Card exposing (MarkdownCard)
import Element as E exposing (Element, column)
import Scripta.API
import Scripta.Language exposing (Language(..))


viewRenderedCard : String -> Int -> msg -> Element msg
viewRenderedCard text count renderMsg =
    let
        settings : a -> { windowWidth : number, counter : a, selectedId : String, selectedSlug : Maybe b, scale : Float }
        settings counter =
            { windowWidth = 500
            , counter = counter
            , selectedId = "--"
            , selectedSlug = Nothing
            , scale = 0.8
            }
    in
    column
        []
        (Scripta.API.compile (settings count) XMarkdownLang text |> List.map (E.map renderMsg))
