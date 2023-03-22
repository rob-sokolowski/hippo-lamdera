module Evergreen.V45.Api.Admin exposing (..)

import Evergreen.V45.Api.Card
import Evergreen.V45.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V45.Api.Card.CardId
    , userId : Evergreen.V45.Api.User.UserId
    , question : String
    , answer : String
    }
