module Bridge exposing (..)

import Api.Card exposing (CardId, FlashCard, Grade)
import Api.User exposing (User, UserId)
import Lamdera


sendToBackend =
    Lamdera.sendToBackend


type ToBackend
    = SignedOut User
      -- Req/resp paired messages
    | ProfileGet_Profile__Username_ { username : String }
    | UserAuthentication_Login { params : { email : String, password : String } }
    | UserRegistration_Register { params : { username : String, email : String, password : String } }
    | CreateCard_Cards FlashCard UserId
    | FetchUsersStudyCards_Study User
    | FetchUsersStudySummary_Study User
    | UserSubmitGrade_Study CardId Grade
    | FetchUsersCatalog_Catalog User
    | DeleteCard_Catalog CardId UserId
