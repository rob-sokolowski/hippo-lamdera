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
      -- Req/resp paired messages
      --| UserAuthentication_Login { params : { email : String, password : String } }
      --| UserRegistration_Register { params : { username : String, email : String, password : String } }
    | CreateCard_Cards FlashCard UserId
    | FetchUsersStudyCards_Study User
    | FetchUsersStudySummary_Study User
    | UserSubmitGrade_Study CardId Grade
    | FetchUsersCatalog_Catalog User
    | DeleteCard_Catalog CardId UserId
