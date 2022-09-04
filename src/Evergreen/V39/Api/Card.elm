module Evergreen.V39.Api.Card exposing (..)

import Evergreen.V39.Api.User
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
    , tags : List String
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
    , userId : Evergreen.V39.Api.User.UserId
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
