module Evergreen.V30.Pages.Catalog exposing (..)

import Evergreen.V30.Api.Card
import Evergreen.V30.Api.Data
import Evergreen.V30.Api.User
import Markdown.Render
import Time


type alias Model =
    { user : Maybe Evergreen.V30.Api.User.User
    , zone : Time.Zone
    , wiredCards : Evergreen.V30.Api.Data.Data (List Evergreen.V30.Api.Card.CardEnvelope)
    , selectedEnv : Maybe Evergreen.V30.Api.Card.CardEnvelope
    , hoveredOnEnv : Maybe Evergreen.V30.Api.Card.CardEnvelope
    , deletedCardId : Maybe Evergreen.V30.Api.Card.CardId
    }


type Msg
    = FetchUserCatalog Evergreen.V30.Api.User.User
    | GotUserCatalog (Evergreen.V30.Api.Data.Data (List Evergreen.V30.Api.Card.CardEnvelope))
    | GotDeleteCardResponse Evergreen.V30.Api.Card.CardId
    | UserSelectedCard Evergreen.V30.Api.Card.CardEnvelope
    | UserClickedDelete Evergreen.V30.Api.Card.CardId Evergreen.V30.Api.User.UserId
    | UserMousesOver Evergreen.V30.Api.Card.CardEnvelope
    | ClearTableHover
    | MarkdownMsg Markdown.Render.MarkdownMsg
    | Noop
