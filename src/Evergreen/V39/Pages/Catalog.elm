module Evergreen.V39.Pages.Catalog exposing (..)

import Evergreen.V39.Api.Card
import Evergreen.V39.Api.Data
import Evergreen.V39.Api.User
import Evergreen.V39.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V39.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V39.Api.Data.Data (List Evergreen.V39.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V39.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V39.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V39.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V39.Api.User.User
    | GotUserCatalog (Evergreen.V39.Api.Data.Data (List Evergreen.V39.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V39.Api.Card.CardId
    | UserSelectedCard Evergreen.V39.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V39.Api.Card.CardId Evergreen.V39.Api.User.UserId
    | UserMousesOver Evergreen.V39.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V39.Scripta.API.Msg
    | Noop
