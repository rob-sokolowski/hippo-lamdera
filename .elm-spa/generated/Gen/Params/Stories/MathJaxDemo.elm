module Gen.Params.Stories.MathJaxDemo exposing (Params, parser)

import Url.Parser as Parser exposing ((</>), Parser)


type alias Params =
    ()


parser =
    (Parser.s "stories" </> Parser.s "math-jax-demo")

