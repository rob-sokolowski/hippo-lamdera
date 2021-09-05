module Components.Footer exposing (view)

import Html exposing (..)
import Html.Attributes exposing (class, href)


view : Html msg
view =
    footer []
        [ div [ class "container" ]
            [ a [ class "logo-font", href "/" ] [ text "hippo" ]
            , span [ class "attribution" ]
                [ text "Code & design licensed under MIT."
                ]
            ]
        ]
