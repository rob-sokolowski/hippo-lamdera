module Components.Navbar exposing (view)

import Api.User exposing (User)
import Element as E exposing (..)
import Element.Background as Background
import Element.Border as Border
import Element.Events exposing (..)
import Element.Font as Font
import Gen.Route as Route exposing (Route)
import Html exposing (..)
import Html.Attributes exposing (class, classList, href)
import Html.Events as Events


view :
    { user : Maybe User
    , currentRoute : Route
    , onSignOut : msg
    }
    -> Element msg
view options =
    E.text "NAV!!!"
