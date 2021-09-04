module Evergreen.V7.Pages.Home_ exposing (..)

type Tab
    = Global


type alias Model = 
    { tab : Tab
    }


type Msg
    = Noop