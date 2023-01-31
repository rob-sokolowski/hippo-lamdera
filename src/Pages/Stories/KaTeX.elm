module Pages.Stories.KaTeX exposing (..)

import Html exposing (Html)
import Html.Attributes as HA
import Json.Encode


type DisplayMode
    = InlineMathMode
    | DisplayMathMode


display : String -> Html msg
display str =
    Html.div []
        [ mathText DisplayMathMode str ]


inline : String -> Html msg
inline str =
    Html.span []
        [ mathText InlineMathMode str ]


mathText : DisplayMode -> String -> Html msg
mathText displayMode str =
    Html.node "math-text"
        [ HA.property "display" (Json.Encode.bool (isDisplayMathMode displayMode))
        , HA.property "content" (Json.Encode.string str)
        ]
        []


isDisplayMathMode : DisplayMode -> Bool
isDisplayMathMode displayMode =
    case displayMode of
        InlineMathMode ->
            False

        DisplayMathMode ->
            True
