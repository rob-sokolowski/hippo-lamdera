module Evergreen.V54.Api.Admin exposing (..)

import Evergreen.V54.Api.Card
import Evergreen.V54.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V54.Api.Card.CardId
    , userId : Evergreen.V54.Api.User.UserId
    , question : String
    , answer : String
    }
