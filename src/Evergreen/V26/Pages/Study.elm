module Evergreen.V26.Pages.Study exposing (..)

import Evergreen.V26.Api.Card
import Evergreen.V26.Api.Data
import Evergreen.V26.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V26.Api.Data.Data (List Evergreen.V26.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V26.Api.Data.Data Evergreen.V26.Api.Card.CardId
    , sessionSummary : Evergreen.V26.Api.Data.Data Evergreen.V26.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V26.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V26.Api.User.User
    | GotUserCards (Evergreen.V26.Api.Data.Data (List Evergreen.V26.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V26.Api.Card.CardId Evergreen.V26.Api.Card.Grade
    | GotGradedResponse (Evergreen.V26.Api.Data.Data Evergreen.V26.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V26.Api.Data.Data Evergreen.V26.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg
