module Evergreen.V25.Pages.Study exposing (..)

import Evergreen.V25.Api.Card
import Evergreen.V25.Api.Data
import Evergreen.V25.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V25.Api.Data.Data (List Evergreen.V25.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V25.Api.Data.Data Evergreen.V25.Api.Card.CardId
    , sessionSummary : Evergreen.V25.Api.Data.Data Evergreen.V25.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V25.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V25.Api.User.User
    | GotUserCards (Evergreen.V25.Api.Data.Data (List Evergreen.V25.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V25.Api.Card.CardId Evergreen.V25.Api.Card.Grade
    | GotGradedResponse (Evergreen.V25.Api.Data.Data Evergreen.V25.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V25.Api.Data.Data Evergreen.V25.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg
