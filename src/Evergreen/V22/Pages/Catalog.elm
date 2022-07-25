module Evergreen.V22.Pages.Catalog exposing (..)

import Evergreen.V22.Api.Card
import Evergreen.V22.Api.Data
import Evergreen.V22.Api.User
import Markdown.Render
import Time


type alias Model =
    { user : Maybe Evergreen.V22.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V22.Api.Data.Data (List Evergreen.V22.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V22.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V22.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V22.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V22.Api.User.User
    | GotUserCatalog (Evergreen.V22.Api.Data.Data (List Evergreen.V22.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V22.Api.Card.CardId
    | UserSelectedCard Evergreen.V22.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V22.Api.Card.CardId Evergreen.V22.Api.User.UserId
    | UserMousesOver Evergreen.V22.Api.Card.CardEnvelope
    | ClearTableHover
    | MarkdownMsg Markdown.Render.MarkdownMsg
    | Noop
