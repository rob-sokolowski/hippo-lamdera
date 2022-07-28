module Evergreen.V30.Bridge exposing (..)

import Evergreen.V30.Api.Card
import Evergreen.V30.Api.User
import Evergreen.V30.Auth.Common


type ToBackend
    = SignedOut Evergreen.V30.Api.User.User
    | AuthToBackend Evergreen.V30.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V30.Api.Card.FlashCard Evergreen.V30.Api.User.UserId
    | FetchUsersStudyCards_Study Evergreen.V30.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V30.Api.User.User
    | UserSubmitGrade_Study Evergreen.V30.Api.Card.CardId Evergreen.V30.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V30.Api.User.User
    | DeleteCard_Catalog Evergreen.V30.Api.Card.CardId Evergreen.V30.Api.User.UserId
