module Evergreen.V9.Bridge exposing (..)

import Evergreen.V9.Api.Card
import Evergreen.V9.Api.User


type ToBackend
    = SignedOut Evergreen.V9.Api.User.User
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
    | UserUpdate_Settings 
    { params : 
    { username : String
    , email : String
    , password : (Maybe String)
    , image : String
    , bio : String
    }
    }
    | CreateCard_Cards Evergreen.V9.Api.Card.FlashCard Evergreen.V9.Api.User.UserId
    | FetchUsersStudyCards_Study Evergreen.V9.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V9.Api.User.User
    | UserSubmitGrade_Study Evergreen.V9.Api.Card.CardId Evergreen.V9.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V9.Api.User.User