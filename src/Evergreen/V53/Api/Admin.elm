module Evergreen.V53.Api.Admin exposing (..)

import Evergreen.V53.Api.Card
import Evergreen.V53.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V53.Api.Card.CardId
    , userId : Evergreen.V53.Api.User.UserId
    , question : String
    , answer : String
    }
