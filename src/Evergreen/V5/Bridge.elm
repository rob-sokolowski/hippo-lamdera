module Evergreen.V5.Bridge exposing (..)

import Evergreen.V5.Api.Card
import Evergreen.V5.Api.User


type ToBackend
    = SignedOut Evergreen.V5.Api.User.User
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
            , password : Maybe String
            , image : String
            , bio : String
            }
        }
    | CreateCard_Cards Evergreen.V5.Api.Card.FlashCard
    | FetchAllCards
    | NoOpToBackend
