module Evergreen.V33.Pages.Catalog exposing (..)

import Evergreen.V33.Api.Card
import Evergreen.V33.Api.Data
import Evergreen.V33.Api.User
import Evergreen.V33.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V33.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V33.Api.Data.Data (List Evergreen.V33.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V33.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V33.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V33.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V33.Api.User.User
    | GotUserCatalog (Evergreen.V33.Api.Data.Data (List Evergreen.V33.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V33.Api.Card.CardId
    | UserSelectedCard Evergreen.V33.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V33.Api.Card.CardId Evergreen.V33.Api.User.UserId
    | UserMousesOver Evergreen.V33.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V33.Scripta.API.Msg
    | Noop
