module Evergreen.V1.Components.Editor exposing (..)

type alias Form = 
    { title : String
    , description : String
    , body : String
    , tags : String
    }


type Field
    = Title
    | Description
    | Body
    | Tags