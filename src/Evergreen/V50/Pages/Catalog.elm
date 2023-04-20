module Evergreen.V50.Pages.Catalog exposing (..)

import Evergreen.V50.Api.Card
import Evergreen.V50.Api.Data
import Evergreen.V50.Api.User
import Evergreen.V50.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V50.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V50.Api.Data.Data (List Evergreen.V50.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V50.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V50.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V50.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V50.Api.User.User
    | GotUserCatalog (Evergreen.V50.Api.Data.Data (List Evergreen.V50.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V50.Api.Card.CardId
    | UserSelectedCard Evergreen.V50.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V50.Api.Card.CardId Evergreen.V50.Api.User.UserId
    | UserMousesOver Evergreen.V50.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V50.Scripta.API.Msg
    | Noop
