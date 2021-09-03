module Api.Card exposing (CardEnvelope, FlashCard(..), CardId, PromptFrequency(..), Grade(..), PlainTextCard, processGrade, StudySessionSummary)
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


processGrade : Time.Posix -> CardEnvelope -> Grade -> CardEnvelope
processGrade now c g =
    let
        nowPlusDays n = TE.add TE.Day n Time.utc now
        nowMinusTwo = TE.add TE.Second -2 Time.utc now
        (freq, next) = case g of
            Correct ->
                case c.frequency of
                    Immediately ->
                        (OneDay, nowPlusDays 1)
                    OneDay ->
                        (TwoDays, nowPlusDays 2)
                    TwoDays ->
                        (SevenDays, nowPlusDays 7)
                    SevenDays ->
                        (FourteenDays, nowPlusDays 14)
                    FourteenDays ->
                        (ThirtyDays, nowPlusDays 30)
                    ThirtyDays ->
                        (ThirtyDays, nowPlusDays 30)
            Incorrect ->
                case c.frequency of
                    Immediately ->
                        (Immediately, nowMinusTwo)
                    OneDay ->
                        (Immediately, nowMinusTwo)
                    TwoDays ->
                        (Immediately, nowMinusTwo)
                    SevenDays ->
                        (Immediately, nowMinusTwo)
                    FourteenDays ->
                        (Immediately, nowMinusTwo)
                    ThirtyDays ->
                        (Immediately, nowMinusTwo)
    in
    {c | frequency = freq, nextPromptSchedFor = next}




-- TODO: This type def feels a bit out of place here.
type alias StudySessionSummary =
    {
        usersTotalCardCount : Int
        , cardsToStudy : Int
    }
