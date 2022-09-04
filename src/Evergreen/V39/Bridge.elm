module Evergreen.V39.Bridge exposing (..)

import Evergreen.V39.Api.Card
import Evergreen.V39.Api.User
import Evergreen.V39.Auth.Common


type ToBackend
    = SignedOut Evergreen.V39.Api.User.User
    | AuthToBackend Evergreen.V39.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V39.Api.Card.FlashCard Evergreen.V39.Api.User.UserId
    | FetchAdminSummary Evergreen.V39.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V39.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V39.Api.User.User
    | UserSubmitGrade_Study Evergreen.V39.Api.Card.CardId Evergreen.V39.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V39.Api.User.User
    | DeleteCard_Catalog Evergreen.V39.Api.Card.CardId Evergreen.V39.Api.User.UserId
