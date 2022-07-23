module Evergreen.V17.Pages.Catalog exposing (..)

import Evergreen.V17.Api.Card
import Evergreen.V17.Api.Data
import Evergreen.V17.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V17.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V17.Api.Data.Data (List Evergreen.V17.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V17.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V17.Api.Card.CardEnvelope
    }


type Msg
    = FetchUserCatalog Evergreen.V17.Api.User.User
    | GotUserCatalog (Evergreen.V17.Api.Data.Data (List Evergreen.V17.Api.Card.CardEnvelope))
    | UserSelectedCard Evergreen.V17.Api.Card.CardEnvelope
    | UserMousesOver Evergreen.V17.Api.Card.CardEnvelope
    | ClearTableHover
