module Evergreen.V37.Pages.Catalog exposing (..)

import Evergreen.V37.Api.Card
import Evergreen.V37.Api.Data
import Evergreen.V37.Api.User
import Evergreen.V37.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V37.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V37.Api.Data.Data (List Evergreen.V37.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V37.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V37.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V37.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V37.Api.User.User
    | GotUserCatalog (Evergreen.V37.Api.Data.Data (List Evergreen.V37.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V37.Api.Card.CardId
    | UserSelectedCard Evergreen.V37.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V37.Api.Card.CardId Evergreen.V37.Api.User.UserId
    | UserMousesOver Evergreen.V37.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V37.Scripta.API.Msg
    | Noop
