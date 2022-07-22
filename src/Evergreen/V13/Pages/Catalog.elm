module Evergreen.V13.Pages.Catalog exposing (..)

import Evergreen.V13.Api.Card
import Evergreen.V13.Api.Data
import Evergreen.V13.Api.User
import Time


type alias Model = 
    { user : (Maybe Evergreen.V13.Api.User.User)
    , zone : Time.Zone
    , wiredCards : (Evergreen.V13.Api.Data.Data (List Evergreen.V13.Api.Card.CardEnvelope))
    , selectedEnv : (Maybe Evergreen.V13.Api.Card.CardEnvelope)
    }


type Msg
    = FetchUserCatalog Evergreen.V13.Api.User.User
    | GotUserCatalog (Evergreen.V13.Api.Data.Data (List Evergreen.V13.Api.Card.CardEnvelope))
    | UserSelectedCard Evergreen.V13.Api.Card.CardEnvelope
    | UserMousesOver Evergreen.V13.Api.Card.CardEnvelope