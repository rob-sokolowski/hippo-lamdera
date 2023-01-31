module Evergreen.V41.Api.Admin exposing (..)

import Evergreen.V41.Api.Card
import Evergreen.V41.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V41.Api.Card.CardId
    , userId : Evergreen.V41.Api.User.UserId
    , question : String
    , answer : String
    }
