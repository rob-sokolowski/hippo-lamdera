module Evergreen.V41.Pages.Catalog exposing (..)

import Evergreen.V41.Api.Card
import Evergreen.V41.Api.Data
import Evergreen.V41.Api.User
import Evergreen.V41.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V41.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V41.Api.Data.Data (List Evergreen.V41.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V41.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V41.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V41.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V41.Api.User.User
    | GotUserCatalog (Evergreen.V41.Api.Data.Data (List Evergreen.V41.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V41.Api.Card.CardId
    | UserSelectedCard Evergreen.V41.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V41.Api.Card.CardId Evergreen.V41.Api.User.UserId
    | UserMousesOver Evergreen.V41.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V41.Scripta.API.Msg
    | Noop
