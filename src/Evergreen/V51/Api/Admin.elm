module Evergreen.V51.Api.Admin exposing (..)

import Evergreen.V51.Api.Card
import Evergreen.V51.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V51.Api.Card.CardId
    , userId : Evergreen.V51.Api.User.UserId
    , question : String
    , answer : String
    }
