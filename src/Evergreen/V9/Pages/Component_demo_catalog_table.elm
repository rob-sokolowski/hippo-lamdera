module Evergreen.V9.Pages.Component_demo_catalog_table exposing (..)

import Dict
import Evergreen.V9.Animator
import Evergreen.V9.Api.Card
import Time


type alias Id = String


type State
    = Default
    | Hover


type alias Model = 
    { zone : Time.Zone
    , catalog : (List Evergreen.V9.Api.Card.CardEnvelope)
    , selectedEnv : (Maybe Evergreen.V9.Api.Card.CardEnvelope)
    , buttonStates : (Evergreen.V9.Animator.Timeline (Dict.Dict Id State))
    }


type Msg
    = ReplaceMe