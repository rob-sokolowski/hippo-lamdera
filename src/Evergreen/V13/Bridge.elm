module Evergreen.V13.Bridge exposing (..)

import Evergreen.V13.Api.Card
import Evergreen.V13.Api.User


type ToBackend
    = SignedOut Evergreen.V13.Api.User.User
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
    | CreateCard_Cards Evergreen.V13.Api.Card.FlashCard Evergreen.V13.Api.User.UserId
    | FetchUsersStudyCards_Study Evergreen.V13.Api.User.User
    | FetchUsersStudySummary_Study Evergreen.V13.Api.User.User
    | UserSubmitGrade_Study Evergreen.V13.Api.Card.CardId Evergreen.V13.Api.Card.Grade
    | FetchUsersCatalog_Catalog Evergreen.V13.Api.User.User