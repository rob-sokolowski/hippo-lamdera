module Evergreen.V33.Bridge exposing (..)

import Evergreen.V33.Api.Card
import Evergreen.V33.Api.User
import Evergreen.V33.Auth.Common


type ToBackend
    = SignedOut Evergreen.V33.Api.User.User
    | AuthToBackend Evergreen.V33.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V33.Api.Card.FlashCard Evergreen.V33.Api.User.UserId
    | FetchUsersStudyCards_Study Evergreen.V33.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V33.Api.User.User
    | UserSubmitGrade_Study Evergreen.V33.Api.Card.CardId Evergreen.V33.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V33.Api.User.User
    | DeleteCard_Catalog Evergreen.V33.Api.Card.CardId Evergreen.V33.Api.User.UserId
