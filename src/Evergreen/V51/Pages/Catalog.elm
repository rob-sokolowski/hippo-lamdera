module Evergreen.V51.Pages.Catalog exposing (..)

import Evergreen.V51.Api.Card
import Evergreen.V51.Api.Data
import Evergreen.V51.Api.User
import Evergreen.V51.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V51.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V51.Api.Data.Data (List Evergreen.V51.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V51.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V51.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V51.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V51.Api.User.User
    | GotUserCatalog (Evergreen.V51.Api.Data.Data (List Evergreen.V51.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V51.Api.Card.CardId
    | UserSelectedCard Evergreen.V51.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V51.Api.Card.CardId Evergreen.V51.Api.User.UserId
    | UserMousesOver Evergreen.V51.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V51.Scripta.API.Msg
    | Noop
