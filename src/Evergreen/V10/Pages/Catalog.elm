module Evergreen.V10.Pages.Catalog exposing (..)

import Evergreen.V10.Api.Card
import Evergreen.V10.Api.Data
import Evergreen.V10.Api.User
import Time


type alias Model = 
    { user : (Maybe Evergreen.V10.Api.User.User)
    , zone : Time.Zone
    , wiredCards : (Evergreen.V10.Api.Data.Data (List Evergreen.V10.Api.Card.CardEnvelope))
    , selectedEnv : (Maybe Evergreen.V10.Api.Card.CardEnvelope)
    }


type Msg
    = FetchUserCatalog Evergreen.V10.Api.User.User
    | GotUserCatalog (Evergreen.V10.Api.Data.Data (List Evergreen.V10.Api.Card.CardEnvelope))
    | UserSelectedCard Evergreen.V10.Api.Card.CardEnvelope
    | UserMousesOver Evergreen.V10.Api.Card.CardEnvelope