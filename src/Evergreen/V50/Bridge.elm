module Evergreen.V50.Bridge exposing (..)

import Evergreen.V50.Api.Card
import Evergreen.V50.Api.User
import Evergreen.V50.Auth.Common


type ToBackend
    = SignedOut Evergreen.V50.Api.User.User
    | AuthToBackend Evergreen.V50.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V50.Api.Card.FlashCard Evergreen.V50.Api.User.UserId
    | FetchAdminSummary Evergreen.V50.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V50.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V50.Api.User.User
    | UserSubmitGrade_Study Evergreen.V50.Api.Card.CardId Evergreen.V50.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V50.Api.User.User
    | DeleteCard_Catalog Evergreen.V50.Api.Card.CardId Evergreen.V50.Api.User.UserId
