module Evergreen.V48.Pages.Catalog exposing (..)

import Evergreen.V48.Api.Card
import Evergreen.V48.Api.Data
import Evergreen.V48.Api.User
import Evergreen.V48.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V48.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V48.Api.Data.Data (List Evergreen.V48.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V48.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V48.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V48.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V48.Api.User.User
    | GotUserCatalog (Evergreen.V48.Api.Data.Data (List Evergreen.V48.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V48.Api.Card.CardId
    | UserSelectedCard Evergreen.V48.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V48.Api.Card.CardId Evergreen.V48.Api.User.UserId
    | UserMousesOver Evergreen.V48.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V48.Scripta.API.Msg
    | Noop
