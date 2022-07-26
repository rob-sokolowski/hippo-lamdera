module Evergreen.V26.Bridge exposing (..)

import Evergreen.V26.Api.Card
import Evergreen.V26.Api.User
import Evergreen.V26.Auth.Common


type ToBackend
    = SignedOut Evergreen.V26.Api.User.User
    | AuthToBackend Evergreen.V26.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V26.Api.Card.FlashCard Evergreen.V26.Api.User.UserId
    | FetchUsersStudyCards_Study Evergreen.V26.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V26.Api.User.User
    | UserSubmitGrade_Study Evergreen.V26.Api.Card.CardId Evergreen.V26.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V26.Api.User.User
    | DeleteCard_Catalog Evergreen.V26.Api.Card.CardId Evergreen.V26.Api.User.UserId
