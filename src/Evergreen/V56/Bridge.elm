module Evergreen.V56.Bridge exposing (..)

import Evergreen.V56.Api.Card
import Evergreen.V56.Api.User
import Evergreen.V56.Auth.Common


type ToBackend
    = SignedOut Evergreen.V56.Api.User.User
    | AuthToBackend Evergreen.V56.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V56.Api.Card.FlashCard Evergreen.V56.Api.User.UserId
    | FetchAdminSummary Evergreen.V56.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V56.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V56.Api.User.User
    | UserSubmitGrade_Study Evergreen.V56.Api.Card.CardId Evergreen.V56.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V56.Api.User.User
    | DeleteCard_Catalog Evergreen.V56.Api.Card.CardId Evergreen.V56.Api.User.UserId
