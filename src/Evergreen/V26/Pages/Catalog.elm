module Evergreen.V26.Pages.Catalog exposing (..)

import Evergreen.V26.Api.Card
import Evergreen.V26.Api.Data
import Evergreen.V26.Api.User
import Markdown.Render
import Time


type alias Model =
    { user : Maybe Evergreen.V26.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V26.Api.Data.Data (List Evergreen.V26.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V26.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V26.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V26.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V26.Api.User.User
    | GotUserCatalog (Evergreen.V26.Api.Data.Data (List Evergreen.V26.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V26.Api.Card.CardId
    | UserSelectedCard Evergreen.V26.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V26.Api.Card.CardId Evergreen.V26.Api.User.UserId
    | UserMousesOver Evergreen.V26.Api.Card.CardEnvelope
    | ClearTableHover
    | MarkdownMsg Markdown.Render.MarkdownMsg
    | Noop
