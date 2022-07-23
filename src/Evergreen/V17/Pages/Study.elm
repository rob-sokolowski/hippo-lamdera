module Evergreen.V17.Pages.Study exposing (..)

import Evergreen.V17.Api.Card
import Evergreen.V17.Api.Data
import Evergreen.V17.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V17.Api.Data.Data (List Evergreen.V17.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V17.Api.Data.Data Evergreen.V17.Api.Card.CardId
    , sessionSummary : Evergreen.V17.Api.Data.Data Evergreen.V17.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V17.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V17.Api.User.User
    | GotUserCards (Evergreen.V17.Api.Data.Data (List Evergreen.V17.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V17.Api.Card.CardId Evergreen.V17.Api.Card.Grade
    | GotGradedResponse (Evergreen.V17.Api.Data.Data Evergreen.V17.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V17.Api.Data.Data Evergreen.V17.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg
