module Evergreen.V42.Bridge exposing (..)

import Evergreen.V42.Api.Card
import Evergreen.V42.Api.User
import Evergreen.V42.Auth.Common


type ToBackend
    = SignedOut Evergreen.V42.Api.User.User
    | AuthToBackend Evergreen.V42.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V42.Api.Card.FlashCard Evergreen.V42.Api.User.UserId
    | FetchAdminSummary Evergreen.V42.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V42.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V42.Api.User.User
    | UserSubmitGrade_Study Evergreen.V42.Api.Card.CardId Evergreen.V42.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V42.Api.User.User
    | DeleteCard_Catalog Evergreen.V42.Api.Card.CardId Evergreen.V42.Api.User.UserId
