module Evergreen.V52.Pages.Catalog exposing (..)

import Evergreen.V52.Api.Card
import Evergreen.V52.Api.Data
import Evergreen.V52.Api.User
import Evergreen.V52.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V52.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V52.Api.Data.Data (List Evergreen.V52.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V52.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V52.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V52.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V52.Api.User.User
    | GotUserCatalog (Evergreen.V52.Api.Data.Data (List Evergreen.V52.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V52.Api.Card.CardId
    | UserSelectedCard Evergreen.V52.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V52.Api.Card.CardId Evergreen.V52.Api.User.UserId
    | UserMousesOver Evergreen.V52.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V52.Scripta.API.Msg
    | Noop
