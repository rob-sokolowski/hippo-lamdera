module Evergreen.V48.Api.Admin exposing (..)

import Evergreen.V48.Api.Card
import Evergreen.V48.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V48.Api.Card.CardId
    , userId : Evergreen.V48.Api.User.UserId
    , question : String
    , answer : String
    }
