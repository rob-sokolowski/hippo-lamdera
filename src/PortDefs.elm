port module PortDefs exposing
    ( HtmlId
    , loadVegaSequence
    , markLoadVegaSequenceFinished
    , returnVegaLiteRender
    , vegaLiteElmToJs
    )

import VegaLite


port loadVegaSequence : () -> Cmd msg


port markLoadVegaSequenceFinished : (Int -> msg) -> Sub msg


type alias HtmlId =
    String


type alias NamedSpecs =
    List ( HtmlId, VegaLite.Spec, Bool )


port vegaLiteElmToJs : NamedSpecs -> Cmd msg


port returnVegaLiteRender : (Int -> msg) -> Sub msg
