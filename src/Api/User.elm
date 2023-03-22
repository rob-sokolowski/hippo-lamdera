module Api.User exposing (..)


type alias User =
    { id : Int
    , email : Email
    , username : String
    , bio : Maybe String
    , image : String
    }


type alias UserFull =
    { id : Int
    , email : Email
    , username : String
    , bio : Maybe String
    , image : String
    }


type alias UserId =
    Int


toUser : UserFull -> User
toUser u =
    { id = u.id
    , email = u.email
    , username = u.username
    , bio = u.bio
    , image = u.image
    }


type alias Email =
    String
