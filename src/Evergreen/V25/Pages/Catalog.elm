module Evergreen.V25.Pages.Catalog exposing (..)

import Evergreen.V25.Api.Card
import Evergreen.V25.Api.Data
import Evergreen.V25.Api.User
import Markdown.Render
import Time


type alias Model =
    { user : Maybe Evergreen.V25.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V25.Api.Data.Data (List Evergreen.V25.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V25.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V25.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V25.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V25.Api.User.User
    | GotUserCatalog (Evergreen.V25.Api.Data.Data (List Evergreen.V25.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V25.Api.Card.CardId
    | UserSelectedCard Evergreen.V25.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V25.Api.Card.CardId Evergreen.V25.Api.User.UserId
    | UserMousesOver Evergreen.V25.Api.Card.CardEnvelope
    | ClearTableHover
    | MarkdownMsg Markdown.Render.MarkdownMsg
    | Noop
