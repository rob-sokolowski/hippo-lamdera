module Evergreen.V16.Pages.Study exposing (..)

import Evergreen.V16.Api.Card
import Evergreen.V16.Api.Data
import Evergreen.V16.Api.User
import Markdown.Render


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V16.Api.Data.Data (List Evergreen.V16.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V16.Api.Data.Data Evergreen.V16.Api.Card.CardId
    , sessionSummary : Evergreen.V16.Api.Data.Data Evergreen.V16.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V16.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V16.Api.User.User
    | GotUserCards (Evergreen.V16.Api.Data.Data (List Evergreen.V16.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V16.Api.Card.CardId Evergreen.V16.Api.Card.Grade
    | GotGradedResponse (Evergreen.V16.Api.Data.Data Evergreen.V16.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V16.Api.Data.Data Evergreen.V16.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | MarkdownMsg Markdown.Render.MarkdownMsg
