module Evergreen.V23.Pages.Catalog exposing (..)

import Evergreen.V23.Api.Card
import Evergreen.V23.Api.Data
import Evergreen.V23.Api.User
import Markdown.Render
import Time


type alias Model =
    { user : Maybe Evergreen.V23.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V23.Api.Data.Data (List Evergreen.V23.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V23.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V23.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V23.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V23.Api.User.User
    | GotUserCatalog (Evergreen.V23.Api.Data.Data (List Evergreen.V23.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V23.Api.Card.CardId
    | UserSelectedCard Evergreen.V23.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V23.Api.Card.CardId Evergreen.V23.Api.User.UserId
    | UserMousesOver Evergreen.V23.Api.Card.CardEnvelope
    | ClearTableHover
    | MarkdownMsg Markdown.Render.MarkdownMsg
    | Noop
