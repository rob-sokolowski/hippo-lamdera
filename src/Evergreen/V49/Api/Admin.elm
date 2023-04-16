module Evergreen.V49.Api.Admin exposing (..)

import Evergreen.V49.Api.Card
import Evergreen.V49.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V49.Api.Card.CardId
    , userId : Evergreen.V49.Api.User.UserId
    , question : String
    , answer : String
    }
