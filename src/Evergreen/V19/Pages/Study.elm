module Evergreen.V19.Pages.Study exposing (..)

import Evergreen.V19.Api.Card
import Evergreen.V19.Api.Data
import Evergreen.V19.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V19.Api.Data.Data (List Evergreen.V19.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V19.Api.Data.Data Evergreen.V19.Api.Card.CardId
    , sessionSummary : Evergreen.V19.Api.Data.Data Evergreen.V19.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V19.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V19.Api.User.User
    | GotUserCards (Evergreen.V19.Api.Data.Data (List Evergreen.V19.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V19.Api.Card.CardId Evergreen.V19.Api.Card.Grade
    | GotGradedResponse (Evergreen.V19.Api.Data.Data Evergreen.V19.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V19.Api.Data.Data Evergreen.V19.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg
