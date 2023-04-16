module Evergreen.V49.Pages.Catalog exposing (..)

import Evergreen.V49.Api.Card
import Evergreen.V49.Api.Data
import Evergreen.V49.Api.User
import Evergreen.V49.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V49.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V49.Api.Data.Data (List Evergreen.V49.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V49.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V49.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V49.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V49.Api.User.User
    | GotUserCatalog (Evergreen.V49.Api.Data.Data (List Evergreen.V49.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V49.Api.Card.CardId
    | UserSelectedCard Evergreen.V49.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V49.Api.Card.CardId Evergreen.V49.Api.User.UserId
    | UserMousesOver Evergreen.V49.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V49.Scripta.API.Msg
    | Noop
