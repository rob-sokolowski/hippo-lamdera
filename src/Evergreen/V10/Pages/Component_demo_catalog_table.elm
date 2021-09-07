module Evergreen.V10.Pages.Component_demo_catalog_table exposing (..)

import Dict
import Evergreen.V10.Animator
import Evergreen.V10.Api.Card
import Time


type alias Id = String


type State
    = Default
    | Hover


type alias Model = 
    { zone : Time.Zone
    , catalog : (List Evergreen.V10.Api.Card.CardEnvelope)
    , selectedEnv : (Maybe Evergreen.V10.Api.Card.CardEnvelope)
    , buttonStates : (Evergreen.V10.Animator.Timeline (Dict.Dict Id State))
    }


type Msg
    = AnimatorTick Time.Posix
    | UserHoveredButton Id
    | UserUnhoveredButton Id