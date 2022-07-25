module Evergreen.V23.Pages.Study exposing (..)

import Evergreen.V23.Api.Card
import Evergreen.V23.Api.Data
import Evergreen.V23.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V23.Api.Data.Data (List Evergreen.V23.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V23.Api.Data.Data Evergreen.V23.Api.Card.CardId
    , sessionSummary : Evergreen.V23.Api.Data.Data Evergreen.V23.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V23.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V23.Api.User.User
    | GotUserCards (Evergreen.V23.Api.Data.Data (List Evergreen.V23.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V23.Api.Card.CardId Evergreen.V23.Api.Card.Grade
    | GotGradedResponse (Evergreen.V23.Api.Data.Data Evergreen.V23.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V23.Api.Data.Data Evergreen.V23.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg
