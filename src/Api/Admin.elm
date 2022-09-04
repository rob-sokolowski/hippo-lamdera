module Api.Admin exposing (..)

import Api.Card exposing (CardId)
import Api.User exposing (Email, UserId)


type alias AdminSummary =
    { cardId : CardId
    , userId : UserId
    , question : String
    , answer : String
    }
