module Api.Card exposing (CardEnvelope, FlashCard(..), CardId, PromptFrequency(..), Grade(..), PlainTextCard)
import Api.User exposing (UserId)
import Time


type alias CardId = Int


type FlashCard =
    FlashCardPlainText PlainTextCard



type alias CardEnvelope = 
    {
        id : CardId
        , card : FlashCard
        , userId : UserId
        , createdAt : Time.Posix
        , lastModifiedOn : Time.Posix
    }


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
