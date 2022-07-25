module Gen.Params.Login.GoogleOauth.Callback exposing (Params, parser)

import Url.Parser as Parser exposing ((</>), Parser)


type alias Params =
    ()


parser =
    (Parser.s "login" </> Parser.s "google-oauth" </> Parser.s "callback")

