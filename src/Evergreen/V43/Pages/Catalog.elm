module Evergreen.V43.Pages.Catalog exposing (..)

import Evergreen.V43.Api.Card
import Evergreen.V43.Api.Data
import Evergreen.V43.Api.User
import Evergreen.V43.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V43.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V43.Api.Data.Data (List Evergreen.V43.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V43.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V43.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V43.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V43.Api.User.User
    | GotUserCatalog (Evergreen.V43.Api.Data.Data (List Evergreen.V43.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V43.Api.Card.CardId
    | UserSelectedCard Evergreen.V43.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V43.Api.Card.CardId Evergreen.V43.Api.User.UserId
    | UserMousesOver Evergreen.V43.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V43.Scripta.API.Msg
    | Noop
