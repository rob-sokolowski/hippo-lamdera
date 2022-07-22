module Evergreen.V13.Pages.Study exposing (..)

import Evergreen.V13.Api.Card
import Evergreen.V13.Api.Data
import Evergreen.V13.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model = 
    { cardDataFetch : (Evergreen.V13.Api.Data.Data (List Evergreen.V13.Api.Card.CardEnvelope))
    , promptStatus : PromptStatus
    , gradeSubmit : (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.Card.CardId)
    , sessionSummary : (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.Card.StudySessionSummary)
    , user : (Maybe Evergreen.V13.Api.User.User)
    }


type Msg
    = FetchCards Evergreen.V13.Api.User.User
    | GotUserCards (Evergreen.V13.Api.Data.Data (List Evergreen.V13.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V13.Api.Card.CardId Evergreen.V13.Api.Card.Grade
    | GotGradedResponse (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg