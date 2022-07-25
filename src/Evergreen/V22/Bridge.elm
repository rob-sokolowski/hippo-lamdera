module Evergreen.V22.Bridge exposing (..)

import Evergreen.V22.Api.Card
import Evergreen.V22.Api.User


type ToBackend
    = SignedOut Evergreen.V22.Api.User.User
    | ProfileGet_Profile__Username_
        { username : String
        }
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
    | CreateCard_Cards Evergreen.V22.Api.Card.FlashCard Evergreen.V22.Api.User.UserId
    | FetchUsersStudyCards_Study Evergreen.V22.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V22.Api.User.User
    | UserSubmitGrade_Study Evergreen.V22.Api.Card.CardId Evergreen.V22.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V22.Api.User.User
    | DeleteCard_Catalog Evergreen.V22.Api.Card.CardId Evergreen.V22.Api.User.UserId
