module Evergreen.V54.Bridge exposing (..)

import Evergreen.V54.Api.Card
import Evergreen.V54.Api.User
import Evergreen.V54.Auth.Common


type ToBackend
    = SignedOut Evergreen.V54.Api.User.User
    | AuthToBackend Evergreen.V54.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V54.Api.Card.FlashCard Evergreen.V54.Api.User.UserId
    | FetchAdminSummary Evergreen.V54.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V54.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V54.Api.User.User
    | UserSubmitGrade_Study Evergreen.V54.Api.Card.CardId Evergreen.V54.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V54.Api.User.User
    | DeleteCard_Catalog Evergreen.V54.Api.Card.CardId Evergreen.V54.Api.User.UserId
