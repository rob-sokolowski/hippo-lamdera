module Evergreen.V60.Pages.Catalog exposing (..)

import Evergreen.V60.Api.Card
import Evergreen.V60.Api.Data
import Evergreen.V60.Api.User
import Evergreen.V60.Scripta.API
import Time


type Msg
    = FetchUserCatalog Evergreen.V60.Api.User.User
    | GotUserCatalog (Evergreen.V60.Api.Data.Data (List Evergreen.V60.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V60.Api.Card.CardId
    | UserSelectedCard Evergreen.V60.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V60.Api.Card.CardId Evergreen.V60.Api.User.UserId
    | UserMousesOver Evergreen.V60.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V60.Scripta.API.Msg
    | Noop


type alias Model =
    { user : Maybe Evergreen.V60.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V60.Api.Data.Data (List Evergreen.V60.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V60.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V60.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V60.Api.Card.CardId
    }
