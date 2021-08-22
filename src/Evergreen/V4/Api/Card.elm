module Evergreen.V4.Api.Card exposing (..)


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
    = FlashCardPlainText PlainTextCard


type alias CardId =
    Int
