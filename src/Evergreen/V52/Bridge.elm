module Evergreen.V52.Bridge exposing (..)

import Evergreen.V52.Api.Card
import Evergreen.V52.Api.User
import Evergreen.V52.Auth.Common
import Evergreen.V52.VellumClient


type ToBackend
    = SignedOut Evergreen.V52.Api.User.User
    | AuthToBackend Evergreen.V52.Auth.Common.ToBackend
    | CreateCard_Cards Evergreen.V52.Api.Card.FlashCard Evergreen.V52.Api.User.UserId
    | FetchAdminSummary Evergreen.V52.Api.User.User
    | FetchUsersStudyCards_Study Evergreen.V52.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V52.Api.User.User
    | UserSubmitGrade_Study Evergreen.V52.Api.Card.CardId Evergreen.V52.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V52.Api.User.User
    | DeleteCard_Catalog Evergreen.V52.Api.Card.CardId Evergreen.V52.Api.User.UserId
    | Proxy_VellumApi Evergreen.V52.VellumClient.VellumInputValues
