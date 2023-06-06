module Evergreen.V56.Api.Admin exposing (..)

import Evergreen.V56.Api.Card
import Evergreen.V56.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V56.Api.Card.CardId
    , userId : Evergreen.V56.Api.User.UserId
    , question : String
    , answer : String
    }
