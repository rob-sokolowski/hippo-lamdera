module Evergreen.V40.Api.Admin exposing (..)

import Evergreen.V40.Api.Card
import Evergreen.V40.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V40.Api.Card.CardId
    , userId : Evergreen.V40.Api.User.UserId
    , question : String
    , answer : String
    }
