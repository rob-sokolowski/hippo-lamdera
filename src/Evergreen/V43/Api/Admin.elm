module Evergreen.V43.Api.Admin exposing (..)

import Evergreen.V43.Api.Card
import Evergreen.V43.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V43.Api.Card.CardId
    , userId : Evergreen.V43.Api.User.UserId
    , question : String
    , answer : String
    }
