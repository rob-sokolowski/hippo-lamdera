module Evergreen.V21.Pages.Catalog exposing (..)

import Evergreen.V21.Api.Card
import Evergreen.V21.Api.Data
import Evergreen.V21.Api.User
import Markdown.Render
import Time


type alias Model =
    { user : Maybe Evergreen.V21.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V21.Api.Data.Data (List Evergreen.V21.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V21.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V21.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V21.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V21.Api.User.User
    | GotUserCatalog (Evergreen.V21.Api.Data.Data (List Evergreen.V21.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V21.Api.Card.CardId
    | UserSelectedCard Evergreen.V21.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V21.Api.Card.CardId Evergreen.V21.Api.User.UserId
    | UserMousesOver Evergreen.V21.Api.Card.CardEnvelope
    | ClearTableHover
    | MarkdownMsg Markdown.Render.MarkdownMsg
    | Noop
