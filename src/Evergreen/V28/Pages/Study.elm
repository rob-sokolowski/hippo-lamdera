module Evergreen.V28.Pages.Study exposing (..)

import Evergreen.V28.Api.Card
import Evergreen.V28.Api.Data
import Evergreen.V28.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V28.Api.Data.Data (List Evergreen.V28.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V28.Api.Data.Data Evergreen.V28.Api.Card.CardId
    , sessionSummary : Evergreen.V28.Api.Data.Data Evergreen.V28.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V28.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V28.Api.User.User
    | GotUserCards (Evergreen.V28.Api.Data.Data (List Evergreen.V28.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V28.Api.Card.CardId Evergreen.V28.Api.Card.Grade
    | GotGradedResponse (Evergreen.V28.Api.Data.Data Evergreen.V28.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V28.Api.Data.Data Evergreen.V28.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg
