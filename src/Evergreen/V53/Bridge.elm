module Evergreen.V53.Bridge exposing (..)

import Evergreen.V53.Api.Card
import Evergreen.V53.Api.User
import Evergreen.V53.Auth.Common


type ToBackend
    = SignedOut Evergreen.V53.Api.User.User
    | AuthToBackend Evergreen.V53.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V53.Api.Card.FlashCard Evergreen.V53.Api.User.UserId
    | FetchAdminSummary Evergreen.V53.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V53.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V53.Api.User.User
    | UserSubmitGrade_Study Evergreen.V53.Api.Card.CardId Evergreen.V53.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V53.Api.User.User
    | DeleteCard_Catalog Evergreen.V53.Api.Card.CardId Evergreen.V53.Api.User.UserId
