module Components.Navbar exposing (view)

import Api.User exposing (User)
import Components.Styling as Styling
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Gen.Route as Route exposing (Route)


view :
    { user : Maybe User
    , currentRoute : Route
    , onSignOut : msg
    }
    -> Element msg
view options =
    row
        [ width (fill |> maximum 1200)
        , height (px 50)
        , Border.color Styling.black
        , Border.width 0
        , centerX
        ]
        [ row
            [ spacing 10
            , padding 5
            , alignRight
            ]
            [ link [ Font.color Styling.blue ]
                { url = Route.toHref Route.Home_
                , label = text "Home"
                }
            , link [ Font.color Styling.blue ]
                { url = Route.toHref Route.Login
                , label = text "Sign in"
                }
            , link [ Font.color Styling.blue ]
                { url = Route.toHref Route.Register
                , label = text "Sign up"
                }
            ]
        ]
