module Evergreen.V53.Pages.Catalog exposing (..)

import Evergreen.V53.Api.Card
import Evergreen.V53.Api.Data
import Evergreen.V53.Api.User
import Evergreen.V53.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V53.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V53.Api.Data.Data (List Evergreen.V53.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V53.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V53.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V53.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V53.Api.User.User
    | GotUserCatalog (Evergreen.V53.Api.Data.Data (List Evergreen.V53.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V53.Api.Card.CardId
    | UserSelectedCard Evergreen.V53.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V53.Api.Card.CardId Evergreen.V53.Api.User.UserId
    | UserMousesOver Evergreen.V53.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V53.Scripta.API.Msg
    | Noop
