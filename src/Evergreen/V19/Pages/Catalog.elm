module Evergreen.V19.Pages.Catalog exposing (..)

import Evergreen.V19.Api.Card
import Evergreen.V19.Api.Data
import Evergreen.V19.Api.User
import Time


type alias Model =
    { user : Maybe Evergreen.V19.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V19.Api.Data.Data (List Evergreen.V19.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V19.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V19.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V19.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V19.Api.User.User
    | GotUserCatalog (Evergreen.V19.Api.Data.Data (List Evergreen.V19.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V19.Api.Card.CardId
    | UserSelectedCard Evergreen.V19.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V19.Api.Card.CardId Evergreen.V19.Api.User.UserId
    | UserMousesOver Evergreen.V19.Api.Card.CardEnvelope
    | ClearTableHover
    | Noop
