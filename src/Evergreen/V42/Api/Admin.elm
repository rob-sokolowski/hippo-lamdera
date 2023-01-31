module Evergreen.V42.Api.Admin exposing (..)

import Evergreen.V42.Api.Card
import Evergreen.V42.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V42.Api.Card.CardId
    , userId : Evergreen.V42.Api.User.UserId
    , question : String
    , answer : String
    }
