module Evergreen.V48.Bridge exposing (..)

import Evergreen.V48.Api.Card
import Evergreen.V48.Api.User
import Evergreen.V48.Auth.Common


type ToBackend
    = SignedOut Evergreen.V48.Api.User.User
    | AuthToBackend Evergreen.V48.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V48.Api.Card.FlashCard Evergreen.V48.Api.User.UserId
    | FetchAdminSummary Evergreen.V48.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V48.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V48.Api.User.User
    | UserSubmitGrade_Study Evergreen.V48.Api.Card.CardId Evergreen.V48.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V48.Api.User.User
    | DeleteCard_Catalog Evergreen.V48.Api.Card.CardId Evergreen.V48.Api.User.UserId
