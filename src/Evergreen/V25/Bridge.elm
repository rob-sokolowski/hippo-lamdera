module Evergreen.V25.Bridge exposing (..)

import Evergreen.V25.Api.Card
import Evergreen.V25.Api.User
import Evergreen.V25.Auth.Common


type ToBackend
    = SignedOut Evergreen.V25.Api.User.User
    | AuthToBackend Evergreen.V25.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V25.Api.Card.FlashCard Evergreen.V25.Api.User.UserId
    | FetchUsersStudyCards_Study Evergreen.V25.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V25.Api.User.User
    | UserSubmitGrade_Study Evergreen.V25.Api.Card.CardId Evergreen.V25.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V25.Api.User.User
    | DeleteCard_Catalog Evergreen.V25.Api.Card.CardId Evergreen.V25.Api.User.UserId
