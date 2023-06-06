module Evergreen.V56.Pages.Catalog exposing (..)

import Evergreen.V56.Api.Card
import Evergreen.V56.Api.Data
import Evergreen.V56.Api.User
import Evergreen.V56.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V56.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V56.Api.Data.Data (List Evergreen.V56.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V56.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V56.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V56.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V56.Api.User.User
    | GotUserCatalog (Evergreen.V56.Api.Data.Data (List Evergreen.V56.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V56.Api.Card.CardId
    | UserSelectedCard Evergreen.V56.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V56.Api.Card.CardId Evergreen.V56.Api.User.UserId
    | UserMousesOver Evergreen.V56.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V56.Scripta.API.Msg
    | Noop
