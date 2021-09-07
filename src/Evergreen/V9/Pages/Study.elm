module Evergreen.V9.Pages.Study exposing (..)

import Evergreen.V9.Api.Card
import Evergreen.V9.Api.Data
import Evergreen.V9.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model = 
    { cardDataFetch : (Evergreen.V9.Api.Data.Data (List Evergreen.V9.Api.Card.CardEnvelope))
    , promptStatus : PromptStatus
    , gradeSubmit : (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.Card.CardId)
    , sessionSummary : (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.Card.StudySessionSummary)
    , user : (Maybe Evergreen.V9.Api.User.User)
    }


type Msg
    = FetchCards Evergreen.V9.Api.User.User
    | GotUserCards (Evergreen.V9.Api.Data.Data (List Evergreen.V9.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V9.Api.Card.CardId Evergreen.V9.Api.Card.Grade
    | GotGradedResponse (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg