module Gen.Params.Component_demo_catalog_table exposing (Params, parser)

import Url.Parser as Parser exposing ((</>), Parser)


type alias Params =
    ()


parser =
    (Parser.s "component_demo_catalog_table")

