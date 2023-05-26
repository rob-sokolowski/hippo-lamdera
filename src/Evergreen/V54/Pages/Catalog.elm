module Evergreen.V54.Pages.Catalog exposing (..)

import Evergreen.V54.Api.Card
import Evergreen.V54.Api.Data
import Evergreen.V54.Api.User
import Evergreen.V54.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V54.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V54.Api.Data.Data (List Evergreen.V54.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V54.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V54.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V54.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V54.Api.User.User
    | GotUserCatalog (Evergreen.V54.Api.Data.Data (List Evergreen.V54.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V54.Api.Card.CardId
    | UserSelectedCard Evergreen.V54.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V54.Api.Card.CardId Evergreen.V54.Api.User.UserId
    | UserMousesOver Evergreen.V54.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V54.Scripta.API.Msg
    | Noop
