module Evergreen.V21.Pages.Study exposing (..)

import Evergreen.V21.Api.Card
import Evergreen.V21.Api.Data
import Evergreen.V21.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V21.Api.Data.Data (List Evergreen.V21.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V21.Api.Data.Data Evergreen.V21.Api.Card.CardId
    , sessionSummary : Evergreen.V21.Api.Data.Data Evergreen.V21.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V21.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V21.Api.User.User
    | GotUserCards (Evergreen.V21.Api.Data.Data (List Evergreen.V21.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V21.Api.Card.CardId Evergreen.V21.Api.Card.Grade
    | GotGradedResponse (Evergreen.V21.Api.Data.Data Evergreen.V21.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V21.Api.Data.Data Evergreen.V21.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg
