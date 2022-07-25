module Evergreen.V23.Bridge exposing (..)

import Evergreen.V23.Api.Card
import Evergreen.V23.Api.User


type ToBackend
    = SignedOut Evergreen.V23.Api.User.User
    | UserAuthentication_Login
        { params :
            { email : String
            , password : String
            }
        }
    | UserRegistration_Register
        { params :
            { username : String
            , email : String
            , password : String
            }
        }
    | CreateCard_Cards Evergreen.V23.Api.Card.FlashCard Evergreen.V23.Api.User.UserId
    | FetchUsersStudyCards_Study Evergreen.V23.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V23.Api.User.User
    | UserSubmitGrade_Study Evergreen.V23.Api.Card.CardId Evergreen.V23.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V23.Api.User.User
    | DeleteCard_Catalog Evergreen.V23.Api.Card.CardId Evergreen.V23.Api.User.UserId
