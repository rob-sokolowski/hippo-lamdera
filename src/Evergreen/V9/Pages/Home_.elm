module Evergreen.V9.Pages.Home_ exposing (..)

type Tab
    = Global


type alias Model = 
    { tab : Tab
    }


type Msg
    = Noop