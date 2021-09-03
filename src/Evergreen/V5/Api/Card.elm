module Evergreen.V5.Api.Card exposing (..)

import Evergreen.V5.Api.User
import Time


type alias PlainTextCard = 
    { question : String
    , answer : String
    }


type FlashCard
    = FlashCardPlainText PlainTextCard


type alias CardId = Int


type PromptFrequency
    = Immediately
    | OneDay
    | TwoDays
    | SevenDays
    | FourteenDays
    | ThirtyDays


type alias CardEnvelope = 
    { id : CardId
    , card : FlashCard
    , userId : Evergreen.V5.Api.User.UserId
    , createdAt : Time.Posix
    , lastModifiedOn : Time.Posix
    , nextPromptSchedFor : Time.Posix
    , frequency : PromptFrequency
    }


type Grade
    = Correct
    | Incorrect