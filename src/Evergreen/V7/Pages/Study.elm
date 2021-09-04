module Evergreen.V7.Pages.Study exposing (..)

import Evergreen.V7.Api.Card
import Evergreen.V7.Api.Data
import Evergreen.V7.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model = 
    { cardDataFetch : (Evergreen.V7.Api.Data.Data (List Evergreen.V7.Api.Card.CardEnvelope))
    , promptStatus : PromptStatus
    , gradeSubmit : (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.Card.CardId)
    , sessionSummary : (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.Card.StudySessionSummary)
    , user : (Maybe Evergreen.V7.Api.User.User)
    }


type Msg
    = FetchCards Evergreen.V7.Api.User.User
    | GotUserCards (Evergreen.V7.Api.Data.Data (List Evergreen.V7.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V7.Api.Card.CardId Evergreen.V7.Api.Card.Grade
    | GotGradedResponse (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg