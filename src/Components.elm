module Components exposing (..)

import Api.User exposing (User)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Element.Input as Input
import Gen.Route as Route exposing (Route)
import Palette


viewNavbar :
    { user : Maybe User
    , currentRoute : Route
    , onSignOut : msg
    }
    -> Element msg
viewNavbar options =
    let
        links =
            case options.user of
                Nothing ->
                    [ link [ Font.color Palette.blue ]
                        { url = Route.toHref Route.Home_
                        , label = text "Home"
                        }
                    , link [ alignRight, Font.color Palette.blue ]
                        { url = Route.toHref Route.Login
                        , label = text "Sign in"
                        }
                    ]

                Just user ->
                    [ link [ Font.color Palette.blue ]
                        { url = Route.toHref Route.Home_
                        , label = text "Home"
                        }
                    , link [ Font.color Palette.blue ]
                        { url = Route.toHref Route.Cards
                        , label = text "Cards"
                        }
                    , link [ Font.color Palette.blue ]
                        { url = Route.toHref Route.Catalog
                        , label = text "Catalog"
                        }
                    , link [ Font.color Palette.blue ]
                        { url = Route.toHref Route.Study
                        , label = text "Study"
                        }
                    , link [ alignRight, Font.color Palette.blue ]
                        { url = Route.toHref Route.Admin
                        , label = text "Admin"
                        }
                    , Input.button
                        [ alignRight, Font.color Palette.blue ]
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
        , paddingEach { right = 10, left = 10, top = 0, bottom = 5 }
        , Font.size 26
        ]
        links
