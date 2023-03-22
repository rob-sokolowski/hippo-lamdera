module Evergreen.V48.Render.Msg exposing (..)


type Handling
    = MHStandard
    | MHAsCheatSheet


type SolutionState
    = Unsolved
    | Solved String


type MarkupMsg
    = SendMeta
        { begin : Int
        , end : Int
        , index : Int
        , id : String
        }
    | SendLineNumber
        { begin : Int
        , end : Int
        }
    | SelectId String
    | HighlightId String
    | GetPublicDocument Handling String
    | GetPublicDocumentFromAuthor Handling String String
    | GetDocumentWithSlug Handling String
    | ProposeSolution SolutionState
