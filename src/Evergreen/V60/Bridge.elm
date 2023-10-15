module Evergreen.V60.Bridge exposing (..)

import Evergreen.V60.Api.Card
import Evergreen.V60.Api.User
import Evergreen.V60.Auth.Common


type ToBackend
    = SignedOut Evergreen.V60.Api.User.User
    | AuthToBackend Evergreen.V60.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V60.Api.Card.FlashCard Evergreen.V60.Api.User.UserId
    | FetchAdminSummary Evergreen.V60.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V60.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V60.Api.User.User
    | UserSubmitGrade_Study Evergreen.V60.Api.Card.CardId Evergreen.V60.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V60.Api.User.User
    | DeleteCard_Catalog Evergreen.V60.Api.Card.CardId Evergreen.V60.Api.User.UserId
