module View exposing (View, map, none, placeholder, toBrowserDocument)

import Element as E exposing (..)


type alias View msg =
    { title : String
    , body : List (Element msg)
    }


placeholder : String -> View msg
placeholder str =
    { title = str
    , body = [ E.text str ]
    }


none : View msg
none =
    placeholder ""


map : (a -> b) -> View a -> View b
map fn view =
    { title = view.title
    , body = List.map (E.map fn) view.body
    }


toBrowserDocument =
    identity
