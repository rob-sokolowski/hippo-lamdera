module Evergreen.V55.Pages.Catalog exposing (..)

import Evergreen.V55.Api.Card
import Evergreen.V55.Api.Data
import Evergreen.V55.Api.User
import Evergreen.V55.Scripta.API
import Time


type alias Model =
    { user : Maybe Evergreen.V55.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V55.Api.Data.Data (List Evergreen.V55.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V55.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V55.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V55.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V55.Api.User.User
    | GotUserCatalog (Evergreen.V55.Api.Data.Data (List Evergreen.V55.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V55.Api.Card.CardId
    | UserSelectedCard Evergreen.V55.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V55.Api.Card.CardId Evergreen.V55.Api.User.UserId
    | UserMousesOver Evergreen.V55.Api.Card.CardEnvelope
    | ClearTableHover
    | Render Evergreen.V55.Scripta.API.Msg
    | Noop
