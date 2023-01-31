module Gen.Route exposing
    ( Route(..)
    , fromUrl
    , toHref
    )

import Gen.Params.Admin
import Gen.Params.Cards
import Gen.Params.Catalog
import Gen.Params.Home_
import Gen.Params.Login
import Gen.Params.NotFound
import Gen.Params.Study
import Gen.Params.Login.Provider_.Callback
import Gen.Params.Stories.MathJaxDemo
import Url exposing (Url)
import Url.Parser as Parser exposing ((</>), Parser)


type Route
    = Admin
    | Cards
    | Catalog
    | Home_
    | Login
    | NotFound
    | Study
    | Login__Provider___Callback { provider : String }
    | Stories__MathJaxDemo


fromUrl : Url -> Route
fromUrl =
    Parser.parse (Parser.oneOf routes) >> Maybe.withDefault NotFound


routes : List (Parser (Route -> a) a)
routes =
    [ Parser.map Home_ Gen.Params.Home_.parser
    , Parser.map Admin Gen.Params.Admin.parser
    , Parser.map Cards Gen.Params.Cards.parser
    , Parser.map Catalog Gen.Params.Catalog.parser
    , Parser.map Login Gen.Params.Login.parser
    , Parser.map NotFound Gen.Params.NotFound.parser
    , Parser.map Study Gen.Params.Study.parser
    , Parser.map Stories__MathJaxDemo Gen.Params.Stories.MathJaxDemo.parser
    , Parser.map Login__Provider___Callback Gen.Params.Login.Provider_.Callback.parser
    ]


toHref : Route -> String
toHref route =
    let
        joinAsHref : List String -> String
        joinAsHref segments =
            "/" ++ String.join "/" segments
    in
    case route of
        Admin ->
            joinAsHref [ "admin" ]
    
        Cards ->
            joinAsHref [ "cards" ]
    
        Catalog ->
            joinAsHref [ "catalog" ]
    
        Home_ ->
            joinAsHref []
    
        Login ->
            joinAsHref [ "login" ]
    
        NotFound ->
            joinAsHref [ "not-found" ]
    
        Study ->
            joinAsHref [ "study" ]
    
        Login__Provider___Callback params ->
            joinAsHref [ "login", params.provider, "callback" ]
    
        Stories__MathJaxDemo ->
            joinAsHref [ "stories", "math-jax-demo" ]

