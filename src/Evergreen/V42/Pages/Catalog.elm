module Evergreen.V42.Pages.Catalog exposing (..)

import Evergreen.V42.Api.Card
import Evergreen.V42.Api.Data
import Evergreen.V42.Api.User
import Evergreen.V42.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V42.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V42.Api.Data.Data (List Evergreen.V42.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V42.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V42.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V42.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V42.Api.User.User
    | GotUserCatalog (Evergreen.V42.Api.Data.Data (List Evergreen.V42.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V42.Api.Card.CardId
    | UserSelectedCard Evergreen.V42.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V42.Api.Card.CardId Evergreen.V42.Api.User.UserId
    | UserMousesOver Evergreen.V42.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V42.Scripta.API.Msg
    | Noop
