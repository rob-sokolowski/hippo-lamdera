module Gen.Route exposing
    ( Route(..)
    , fromUrl
    , toHref
    )

import Gen.Params.Cards
import Gen.Params.Catalog
import Gen.Params.Component_demo_catalog_table
import Gen.Params.Home_
import Gen.Params.Login
import Gen.Params.NotFound
import Gen.Params.Register
import Gen.Params.Settings
import Gen.Params.Study
import Gen.Params.Profile.Username_
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser)


type Route
    = Cards
    | Catalog
    | Component_demo_catalog_table
    | Home_
    | Login
    | NotFound
    | Register
    | Settings
    | Study
    | Profile__Username_ { username : String }


fromUrl : Url -> Route
fromUrl =
    Parser.parse (Parser.oneOf routes) >> Maybe.withDefault NotFound


routes : List (Parser (Route -> a) a)
routes =
    [ Parser.map Home_ Gen.Params.Home_.parser
    , Parser.map Cards Gen.Params.Cards.parser
    , Parser.map Catalog Gen.Params.Catalog.parser
    , Parser.map Component_demo_catalog_table Gen.Params.Component_demo_catalog_table.parser
    , Parser.map Login Gen.Params.Login.parser
    , Parser.map NotFound Gen.Params.NotFound.parser
    , Parser.map Register Gen.Params.Register.parser
    , Parser.map Settings Gen.Params.Settings.parser
    , Parser.map Study Gen.Params.Study.parser
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
        Cards ->
            joinAsHref [ "cards" ]
    
        Catalog ->
            joinAsHref [ "catalog" ]
    
        Component_demo_catalog_table ->
            joinAsHref [ "component_demo_catalog_table" ]
    
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
    
        Study ->
            joinAsHref [ "study" ]
    
        Profile__Username_ params ->
            joinAsHref [ "profile", params.username ]

