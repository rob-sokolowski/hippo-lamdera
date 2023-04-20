module Evergreen.V50.Api.Admin exposing (..)

import Evergreen.V50.Api.Card
import Evergreen.V50.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V50.Api.Card.CardId
    , userId : Evergreen.V50.Api.User.UserId
    , question : String
    , answer : String
    }
