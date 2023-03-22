module Evergreen.V43.Api.Card exposing (..)

import Evergreen.V43.Api.User
import Time


type alias CardId =
    Int


type alias PlainTextCard =
    { question : String
    , answer : String
    }


type alias MarkdownCard =
    { question : String
    , answer : String
    , tag : Maybe String
    }


type FlashCard
    = PlainText PlainTextCard
    | Markdown MarkdownCard


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
    , userId : Evergreen.V43.Api.User.UserId
    , createdAt : Time.Posix
    , lastModifiedOn : Time.Posix
    , nextPromptSchedFor : Time.Posix
    , frequency : PromptFrequency
    }


type alias StudySessionSummary =
    { usersTotalCardCount : Int
    , cardsToStudy : Int
    }


type Grade
    = Correct
    | Incorrect
