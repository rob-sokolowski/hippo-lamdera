module Evergreen.V55.Bridge exposing (..)

import Evergreen.V55.Api.Card
import Evergreen.V55.Api.User
import Evergreen.V55.Auth.Common


type ToBackend
    = SignedOut Evergreen.V55.Api.User.User
    | AuthToBackend Evergreen.V55.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V55.Api.Card.FlashCard Evergreen.V55.Api.User.UserId
    | FetchAdminSummary Evergreen.V55.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V55.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V55.Api.User.User
    | UserSubmitGrade_Study Evergreen.V55.Api.Card.CardId Evergreen.V55.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V55.Api.User.User
    | DeleteCard_Catalog Evergreen.V55.Api.Card.CardId Evergreen.V55.Api.User.UserId
