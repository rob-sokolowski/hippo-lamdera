module Evergreen.V52.Api.Admin exposing (..)

import Evergreen.V52.Api.Card
import Evergreen.V52.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V52.Api.Card.CardId
    , userId : Evergreen.V52.Api.User.UserId
    , question : String
    , answer : String
    }
