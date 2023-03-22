module Evergreen.V45.Bridge exposing (..)

import Evergreen.V45.Api.Card
import Evergreen.V45.Api.User
import Evergreen.V45.Auth.Common


type ToBackend
    = SignedOut Evergreen.V45.Api.User.User
    | AuthToBackend Evergreen.V45.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V45.Api.Card.FlashCard Evergreen.V45.Api.User.UserId
    | FetchAdminSummary Evergreen.V45.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V45.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V45.Api.User.User
    | UserSubmitGrade_Study Evergreen.V45.Api.Card.CardId Evergreen.V45.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V45.Api.User.User
    | DeleteCard_Catalog Evergreen.V45.Api.Card.CardId Evergreen.V45.Api.User.UserId
