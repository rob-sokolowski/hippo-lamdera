port module PortDefs exposing
    ( audioPortFromJS
    , audioPortToJS
    )

import Json.Decode as JD
import Json.Encode as JE


port audioPortToJS : JE.Value -> Cmd msg


port audioPortFromJS : (JD.Value -> msg) -> Sub msg
