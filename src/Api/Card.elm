module Api.Card exposing (FlashCard(..), CardId, PromptFrequency(..), Grade(..), PlainTextCard)


type alias CardId = Int


type FlashCard =
    FlashCardPlainText PlainTextCard


type alias PlainTextCard =
    {
        question : String
        , answer : String
        , frequency : PromptFrequency
    }


type Grade =
    Correct
    | Incorrect


type PromptFrequency
    = Immediately
    | OneDay
    | TwoDays
    | SevenDays
    | FourteenDays
    | ThirtyDays
