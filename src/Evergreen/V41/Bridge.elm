module Evergreen.V41.Bridge exposing (..)

import Evergreen.V41.Api.Card
import Evergreen.V41.Api.User
import Evergreen.V41.Auth.Common


type ToBackend
    = SignedOut Evergreen.V41.Api.User.User
    | AuthToBackend Evergreen.V41.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V41.Api.Card.FlashCard Evergreen.V41.Api.User.UserId
    | FetchAdminSummary Evergreen.V41.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V41.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V41.Api.User.User
    | UserSubmitGrade_Study Evergreen.V41.Api.Card.CardId Evergreen.V41.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V41.Api.User.User
    | DeleteCard_Catalog Evergreen.V41.Api.Card.CardId Evergreen.V41.Api.User.UserId
