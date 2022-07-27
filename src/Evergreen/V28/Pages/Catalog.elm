module Evergreen.V28.Pages.Catalog exposing (..)

import Evergreen.V28.Api.Card
import Evergreen.V28.Api.Data
import Evergreen.V28.Api.User
import Markdown.Render
import Time


type alias Model =
    { user : Maybe Evergreen.V28.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V28.Api.Data.Data (List Evergreen.V28.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V28.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V28.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V28.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V28.Api.User.User
    | GotUserCatalog (Evergreen.V28.Api.Data.Data (List Evergreen.V28.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V28.Api.Card.CardId
    | UserSelectedCard Evergreen.V28.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V28.Api.Card.CardId Evergreen.V28.Api.User.UserId
    | UserMousesOver Evergreen.V28.Api.Card.CardEnvelope
    | ClearTableHover
    | MarkdownMsg Markdown.Render.MarkdownMsg
    | Noop
