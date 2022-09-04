module Evergreen.V39.Api.Admin exposing (..)

import Evergreen.V39.Api.Card
import Evergreen.V39.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V39.Api.Card.CardId
    , userId : Evergreen.V39.Api.User.UserId
    , question : String
    , answer : String
    }
