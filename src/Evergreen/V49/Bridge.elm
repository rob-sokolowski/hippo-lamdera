module Evergreen.V49.Bridge exposing (..)

import Evergreen.V49.Api.Card
import Evergreen.V49.Api.User
import Evergreen.V49.Auth.Common


type ToBackend
    = SignedOut Evergreen.V49.Api.User.User
    | AuthToBackend Evergreen.V49.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V49.Api.Card.FlashCard Evergreen.V49.Api.User.UserId
    | FetchAdminSummary Evergreen.V49.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V49.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V49.Api.User.User
    | UserSubmitGrade_Study Evergreen.V49.Api.Card.CardId Evergreen.V49.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V49.Api.User.User
    | DeleteCard_Catalog Evergreen.V49.Api.Card.CardId Evergreen.V49.Api.User.UserId
