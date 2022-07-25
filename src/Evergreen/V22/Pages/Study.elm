module Evergreen.V22.Pages.Study exposing (..)

import Evergreen.V22.Api.Card
import Evergreen.V22.Api.Data
import Evergreen.V22.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V22.Api.Data.Data (List Evergreen.V22.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V22.Api.Data.Data Evergreen.V22.Api.Card.CardId
    , sessionSummary : Evergreen.V22.Api.Data.Data Evergreen.V22.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V22.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V22.Api.User.User
    | GotUserCards (Evergreen.V22.Api.Data.Data (List Evergreen.V22.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V22.Api.Card.CardId Evergreen.V22.Api.Card.Grade
    | GotGradedResponse (Evergreen.V22.Api.Data.Data Evergreen.V22.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V22.Api.Data.Data Evergreen.V22.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg
