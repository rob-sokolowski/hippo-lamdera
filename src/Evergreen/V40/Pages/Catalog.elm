module Evergreen.V40.Pages.Catalog exposing (..)

import Evergreen.V40.Api.Card
import Evergreen.V40.Api.Data
import Evergreen.V40.Api.User
import Evergreen.V40.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V40.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V40.Api.Data.Data (List Evergreen.V40.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V40.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V40.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V40.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V40.Api.User.User
    | GotUserCatalog (Evergreen.V40.Api.Data.Data (List Evergreen.V40.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V40.Api.Card.CardId
    | UserSelectedCard Evergreen.V40.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V40.Api.Card.CardId Evergreen.V40.Api.User.UserId
    | UserMousesOver Evergreen.V40.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V40.Scripta.API.Msg
    | Noop
