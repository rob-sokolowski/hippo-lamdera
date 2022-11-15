module Evergreen.V40.Bridge exposing (..)

import Evergreen.V40.Api.Card
import Evergreen.V40.Api.User
import Evergreen.V40.Auth.Common


type ToBackend
    = SignedOut Evergreen.V40.Api.User.User
    | AuthToBackend Evergreen.V40.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V40.Api.Card.FlashCard Evergreen.V40.Api.User.UserId
    | FetchAdminSummary Evergreen.V40.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V40.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V40.Api.User.User
    | UserSubmitGrade_Study Evergreen.V40.Api.Card.CardId Evergreen.V40.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V40.Api.User.User
    | DeleteCard_Catalog Evergreen.V40.Api.Card.CardId Evergreen.V40.Api.User.UserId
