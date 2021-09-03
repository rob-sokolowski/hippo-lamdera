module Api.Card exposing (CardEnvelope, FlashCard(..), CardId, PromptFrequency(..), Grade(..), PlainTextCard, grade)
import Api.User exposing (UserId)
import Time
import Time.Extra as TE exposing (..)


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


grade : Time.Posix -> CardEnvelope -> Grade -> CardEnvelope
grade now c g =
    let
        addDays n = TE.add TE.Day n Time.utc now
        (freq, next) = case g of
            Correct ->
                case c.frequency of
                    Immediately ->
                        (OneDay, now)
                    OneDay ->
                        (TwoDays, addDays 1)
                    TwoDays ->
                        (SevenDays, addDays 2)
                    SevenDays ->
                        (FourteenDays, addDays 7)
                    FourteenDays ->
                        (ThirtyDays, addDays 14)
                    ThirtyDays ->
                        (ThirtyDays, addDays 30)
            Incorrect ->
                case c.frequency of
                    Immediately ->
                        (Immediately, now)
                    OneDay ->
                        (Immediately, now)
                    TwoDays ->
                        (Immediately, now)
                    SevenDays ->
                        (Immediately, now)
                    FourteenDays ->
                        (Immediately, now)
                    ThirtyDays ->
                        (Immediately, now)
    in
    {c | frequency = freq, nextPromptSchedFor = next}
