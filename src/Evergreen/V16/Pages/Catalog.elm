module Evergreen.V16.Pages.Catalog exposing (..)

import Evergreen.V16.Api.Card
import Evergreen.V16.Api.Data
import Evergreen.V16.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V16.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V16.Api.Data.Data (List Evergreen.V16.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V16.Api.Card.CardEnvelope
    }


type Msg
    = FetchUserCatalog Evergreen.V16.Api.User.User
    | GotUserCatalog (Evergreen.V16.Api.Data.Data (List Evergreen.V16.Api.Card.CardEnvelope))
    | UserSelectedCard Evergreen.V16.Api.Card.CardEnvelope
    | UserMousesOver Evergreen.V16.Api.Card.CardEnvelope
