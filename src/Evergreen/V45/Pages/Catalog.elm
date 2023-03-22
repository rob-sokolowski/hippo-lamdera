module Evergreen.V45.Pages.Catalog exposing (..)

import Evergreen.V45.Api.Card
import Evergreen.V45.Api.Data
import Evergreen.V45.Api.User
import Evergreen.V45.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V45.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V45.Api.Data.Data (List Evergreen.V45.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V45.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V45.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V45.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V45.Api.User.User
    | GotUserCatalog (Evergreen.V45.Api.Data.Data (List Evergreen.V45.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V45.Api.Card.CardId
    | UserSelectedCard Evergreen.V45.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V45.Api.Card.CardId Evergreen.V45.Api.User.UserId
    | UserMousesOver Evergreen.V45.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V45.Scripta.API.Msg
    | Noop
