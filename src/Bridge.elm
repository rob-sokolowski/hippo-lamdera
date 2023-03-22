module Bridge exposing (..)

import Api.Card exposing (CardId, FlashCard, Grade)
import Api.User exposing (User, UserId)
import Auth.Common
import Lamdera


sendToBackend =
    Lamdera.sendToBackend


type ToBackend
    = SignedOut User
    | AuthToBackend Auth.Common.ToBackend
    | CreateCard_Cards FlashCard UserId
    | FetchAdminSummary User
    | FetchUsersStudyCards_Study User
    | FetchUsersStudySummary_Study User
    | UserSubmitGrade_Study CardId Grade
    | FetchUsersCatalog_Catalog User
    | DeleteCard_Catalog CardId UserId
