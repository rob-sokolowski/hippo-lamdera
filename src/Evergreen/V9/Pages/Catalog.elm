module Evergreen.V9.Pages.Catalog exposing (..)

import Evergreen.V9.Api.Card
import Evergreen.V9.Api.Data
import Evergreen.V9.Api.User
import Time


type alias Model = 
    { user : (Maybe Evergreen.V9.Api.User.User)
    , zone : Time.Zone
    , wiredCards : (Evergreen.V9.Api.Data.Data (List Evergreen.V9.Api.Card.CardEnvelope))
    , selectedEnv : (Maybe Evergreen.V9.Api.Card.CardEnvelope)
    }


type Msg
    = FetchUserCatalog Evergreen.V9.Api.User.User
    | GotUserCatalog (Evergreen.V9.Api.Data.Data (List Evergreen.V9.Api.Card.CardEnvelope))
    | UserSelectedCard Evergreen.V9.Api.Card.CardEnvelope
    | UserMousesOver Evergreen.V9.Api.Card.CardEnvelope