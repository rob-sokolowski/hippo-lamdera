module Api.Card exposing (CardEnvelope, FlashCard(..), CardId, PromptFrequency(..), Grade(..), PlainTextCard, grade)
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
        , nextPromptSchedFor : Time.Posix
        , frequency : PromptFrequency
    }


type alias PlainTextCard =
    {
        question : String
        , answer : String
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


grade : CardEnvelope -> Grade -> CardEnvelope
grade c g =
    let
        (freq, next) = case g of
            Correct ->
                case c.frequency of
                    Immediately ->
                        (OneDay, c.nextPromptSchedFor)
                    OneDay ->
                        (TwoDays, c.nextPromptSchedFor)
                    TwoDays ->
                        (SevenDays, c.nextPromptSchedFor)
                    SevenDays ->
                        (FourteenDays, c.nextPromptSchedFor)
                    FourteenDays ->
                        (ThirtyDays, c.nextPromptSchedFor)
                    ThirtyDays ->
                        (ThirtyDays, c.nextPromptSchedFor)
            Incorrect ->
                case c.frequency of
                    Immediately ->
                        (Immediately, c.nextPromptSchedFor)
                    OneDay ->
                        (Immediately, c.nextPromptSchedFor)
                    TwoDays ->
                        (Immediately, c.nextPromptSchedFor)
                    SevenDays ->
                        (Immediately, c.nextPromptSchedFor)
                    FourteenDays ->
                        (Immediately, c.nextPromptSchedFor)
                    ThirtyDays ->
                        (Immediately, c.nextPromptSchedFor)
    in
    {c | frequency = freq, nextPromptSchedFor = next}
   
                    
                