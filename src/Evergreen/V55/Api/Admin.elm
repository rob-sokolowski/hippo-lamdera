module Evergreen.V55.Api.Admin exposing (..)

import Evergreen.V55.Api.Card
import Evergreen.V55.Api.User


type alias AdminSummary =
    { cardId : Evergreen.V55.Api.Card.CardId
    , userId : Evergreen.V55.Api.User.UserId
    , question : String
    , answer : String
    }
