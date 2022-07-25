module Components.Navbar exposing (view)

import Api.User exposing (User)
import Components.Styling as Styling
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Gen.Route as Route exposing (Route)


view :
    { user : Maybe User
    , currentRoute : Route
    , onSignOut : msg
    }
    -> Element msg
view options =
    let
        links =
            case options.user of
                Nothing ->
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

                Just user ->
                    [ link [ Font.color Styling.blue ]
                        { url = Route.toHref Route.Home_
                        , label = text "Home"
                        }
                    , link [ Font.color Styling.blue ]
                        { url = Route.toHref Route.Cards
                        , label = text "Cards"
                        }
                    , link [ Font.color Styling.blue ]
                        { url = Route.toHref Route.Catalog
                        , label = text "Catalog"
                        }
                    , link [ Font.color Styling.blue ]
                        { url = Route.toHref Route.Study
                        , label = text "Study"
                        }
                    , Input.button
                        [ alignRight ]
                        { onPress = Just options.onSignOut
                        , label = text "Sign Out"
                        }
                    ]
    in
    row
        [ width fill
        , height (px 50)
        , alignRight
        , spacing 20

        --, centerX
        ]
        links
