module Evergreen.V28.Bridge exposing (..)

import Evergreen.V28.Api.Card
import Evergreen.V28.Api.User
import Evergreen.V28.Auth.Common


type ToBackend
    = SignedOut Evergreen.V28.Api.User.User
    | AuthToBackend Evergreen.V28.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V28.Api.Card.FlashCard Evergreen.V28.Api.User.UserId
    | FetchUsersStudyCards_Study Evergreen.V28.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V28.Api.User.User
    | UserSubmitGrade_Study Evergreen.V28.Api.Card.CardId Evergreen.V28.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V28.Api.User.User
    | DeleteCard_Catalog Evergreen.V28.Api.Card.CardId Evergreen.V28.Api.User.UserId
