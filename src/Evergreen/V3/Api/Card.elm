module Evergreen.V3.Api.Card exposing (..)


type alias CardId =
    Int


type PromptFrequency
    = Immediately
    | OneDay
    | TwoDays
    | SevenDays
    | FourteenDays
    | ThirtyDays


type alias PlainTextCard =
    { question : String
    , answer : String
    , frequency : PromptFrequency
    }


type FlashCard
    = PlainText PlainTextCard
