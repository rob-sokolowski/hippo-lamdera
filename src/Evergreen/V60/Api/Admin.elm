module Evergreen.V60.Api.Admin exposing (..)

import Evergreen.V60.Api.Card
import Evergreen.V60.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V60.Api.Card.CardId
    , userId : Evergreen.V60.Api.User.UserId
    , question : String
    , answer : String
    }
