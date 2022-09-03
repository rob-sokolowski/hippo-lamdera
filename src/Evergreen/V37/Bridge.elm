module Evergreen.V37.Bridge exposing (..)

import Evergreen.V37.Api.Card
import Evergreen.V37.Api.User
import Evergreen.V37.Auth.Common


type ToBackend
    = SignedOut Evergreen.V37.Api.User.User
    | AuthToBackend Evergreen.V37.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V37.Api.Card.FlashCard Evergreen.V37.Api.User.UserId
    | FetchAdminSummary Evergreen.V37.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V37.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V37.Api.User.User
    | UserSubmitGrade_Study Evergreen.V37.Api.Card.CardId Evergreen.V37.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V37.Api.User.User
    | DeleteCard_Catalog Evergreen.V37.Api.Card.CardId Evergreen.V37.Api.User.UserId
