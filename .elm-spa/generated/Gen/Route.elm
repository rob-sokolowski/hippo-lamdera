module Gen.Route exposing
    ( Route(..)
    , fromUrl
    , toHref
    )

import Gen.Params.Home_
import Gen.Params.Login
import Gen.Params.NotFound
import Gen.Params.Register
import Gen.Params.Settings
import Gen.Params.Profile.Username_
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser)


type Route
    = Home_
    | Login
    | NotFound
    | Register
    | Settings
    | Profile__Username_ { username : String }


fromUrl : Url -> Route
fromUrl =
    Parser.parse (Parser.oneOf routes) >> Maybe.withDefault NotFound


routes : List (Parser (Route -> a) a)
routes =
    [ Parser.map Home_ Gen.Params.Home_.parser
    , Parser.map Login Gen.Params.Login.parser
    , Parser.map NotFound Gen.Params.NotFound.parser
    , Parser.map Register Gen.Params.Register.parser
    , Parser.map Settings Gen.Params.Settings.parser
    , Parser.map Profile__Username_ Gen.Params.Profile.Username_.parser
    ]


toHref : Route -> String
toHref route =
    let
        joinAsHref : List String -> String
        joinAsHref segments =
            "/" ++ String.join "/" segments
    in
    case route of
        Home_ ->
            joinAsHref []
    
        Login ->
            joinAsHref [ "login" ]
    
        NotFound ->
            joinAsHref [ "not-found" ]
    
        Register ->
            joinAsHref [ "register" ]
    
        Settings ->
            joinAsHref [ "settings" ]
    
        Profile__Username_ params ->
            joinAsHref [ "profile", params.username ]

