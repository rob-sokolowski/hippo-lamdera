module Evergreen.V51.Bridge exposing (..)

import Evergreen.V51.Api.Card
import Evergreen.V51.Api.User
import Evergreen.V51.Auth.Common


type ToBackend
    = SignedOut Evergreen.V51.Api.User.User
    | AuthToBackend Evergreen.V51.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V51.Api.Card.FlashCard Evergreen.V51.Api.User.UserId
    | FetchAdminSummary Evergreen.V51.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V51.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V51.Api.User.User
    | UserSubmitGrade_Study Evergreen.V51.Api.Card.CardId Evergreen.V51.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V51.Api.User.User
    | DeleteCard_Catalog Evergreen.V51.Api.Card.CardId Evergreen.V51.Api.User.UserId
