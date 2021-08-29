module Evergreen.V5.Api.Card exposing (..)

import Evergreen.V5.Api.User
import Time


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


type alias CardEnvelope =
    { id : CardId
    , card : FlashCard
    , userId : Evergreen.V5.Api.User.UserId
    , createdAt : Time.Posix
    , lastModifiedOn : Time.Posix
    }
