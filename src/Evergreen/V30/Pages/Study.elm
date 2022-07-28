module Evergreen.V30.Pages.Study exposing (..)

import Evergreen.V30.Api.Card
import Evergreen.V30.Api.Data
import Evergreen.V30.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V30.Api.Data.Data (List Evergreen.V30.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V30.Api.Data.Data Evergreen.V30.Api.Card.CardId
    , sessionSummary : Evergreen.V30.Api.Data.Data Evergreen.V30.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V30.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V30.Api.User.User
    | GotUserCards (Evergreen.V30.Api.Data.Data (List Evergreen.V30.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V30.Api.Card.CardId Evergreen.V30.Api.Card.Grade
    | GotGradedResponse (Evergreen.V30.Api.Data.Data Evergreen.V30.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V30.Api.Data.Data Evergreen.V30.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg
