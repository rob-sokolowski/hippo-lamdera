module Evergreen.V37.Pages.Study exposing (..)

import Evergreen.V37.Api.Card
import Evergreen.V37.Api.Data
import Evergreen.V37.Api.User
import Evergreen.V37.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V37.Api.Data.Data (List Evergreen.V37.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V37.Api.Data.Data Evergreen.V37.Api.Card.CardId
    , sessionSummary : Evergreen.V37.Api.Data.Data Evergreen.V37.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V37.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V37.Api.User.User
    | GotUserCards (Evergreen.V37.Api.Data.Data (List Evergreen.V37.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V37.Api.Card.CardId Evergreen.V37.Api.Card.Grade
    | GotGradedResponse (Evergreen.V37.Api.Data.Data Evergreen.V37.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V37.Api.Data.Data Evergreen.V37.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V37.Scripta.API.Msg
