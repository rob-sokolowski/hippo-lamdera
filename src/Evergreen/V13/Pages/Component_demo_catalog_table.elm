module Evergreen.V13.Pages.Component_demo_catalog_table exposing (..)

import Dict
import Evergreen.V13.Animator
import Evergreen.V13.Api.Card
import Time


type alias Id = String


type State
    = Default
    | Hover


type alias Model = 
    { zone : Time.Zone
    , catalog : (List Evergreen.V13.Api.Card.CardEnvelope)
    , selectedEnv : (Maybe Evergreen.V13.Api.Card.CardEnvelope)
    , buttonStates : (Evergreen.V13.Animator.Timeline (Dict.Dict Id State))
    }


type Msg
    = AnimatorTick Time.Posix
    | UserHoveredButton Id
    | UserUnhoveredButton Id