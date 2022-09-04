module Evergreen.V39.Pages.Study exposing (..)

import Evergreen.V39.Api.Card
import Evergreen.V39.Api.Data
import Evergreen.V39.Api.User
import Evergreen.V39.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V39.Api.Data.Data (List Evergreen.V39.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V39.Api.Data.Data Evergreen.V39.Api.Card.CardId
    , sessionSummary : Evergreen.V39.Api.Data.Data Evergreen.V39.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V39.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V39.Api.User.User
    | GotUserCards (Evergreen.V39.Api.Data.Data (List Evergreen.V39.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V39.Api.Card.CardId Evergreen.V39.Api.Card.Grade
    | GotGradedResponse (Evergreen.V39.Api.Data.Data Evergreen.V39.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V39.Api.Data.Data Evergreen.V39.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V39.Scripta.API.Msg
