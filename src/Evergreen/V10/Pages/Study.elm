module Evergreen.V10.Pages.Study exposing (..)

import Evergreen.V10.Api.Card
import Evergreen.V10.Api.Data
import Evergreen.V10.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model = 
    { cardDataFetch : (Evergreen.V10.Api.Data.Data (List Evergreen.V10.Api.Card.CardEnvelope))
    , promptStatus : PromptStatus
    , gradeSubmit : (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.Card.CardId)
    , sessionSummary : (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.Card.StudySessionSummary)
    , user : (Maybe Evergreen.V10.Api.User.User)
    }


type Msg
    = FetchCards Evergreen.V10.Api.User.User
    | GotUserCards (Evergreen.V10.Api.Data.Data (List Evergreen.V10.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V10.Api.Card.CardId Evergreen.V10.Api.Card.Grade
    | GotGradedResponse (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg