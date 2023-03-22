module Gen.Params.Stories.KatexDemo exposing (Params, parser)

import Url.Parser as Parser exposing ((</>), Parser)


type alias Params =
    ()


parser =
    (Parser.s "stories" </> Parser.s "katex-demo")

