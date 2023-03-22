module Evergreen.V43.Bridge exposing (..)

import Evergreen.V43.Api.Card
import Evergreen.V43.Api.User
import Evergreen.V43.Auth.Common


type ToBackend
    = SignedOut Evergreen.V43.Api.User.User
    | AuthToBackend Evergreen.V43.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V43.Api.Card.FlashCard Evergreen.V43.Api.User.UserId
    | FetchAdminSummary Evergreen.V43.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V43.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V43.Api.User.User
    | UserSubmitGrade_Study Evergreen.V43.Api.Card.CardId Evergreen.V43.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V43.Api.User.User
    | DeleteCard_Catalog Evergreen.V43.Api.Card.CardId Evergreen.V43.Api.User.UserId
