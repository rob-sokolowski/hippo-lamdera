module Evergreen.V50.Pages.Study exposing (..)

import Evergreen.V50.Api.Card
import Evergreen.V50.Api.Data
import Evergreen.V50.Api.User
import Evergreen.V50.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V50.Api.Data.Data (List Evergreen.V50.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V50.Api.Data.Data Evergreen.V50.Api.Card.CardId
    , sessionSummary : Evergreen.V50.Api.Data.Data Evergreen.V50.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V50.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V50.Api.User.User
    | GotUserCards (Evergreen.V50.Api.Data.Data (List Evergreen.V50.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V50.Api.Card.CardId Evergreen.V50.Api.Card.Grade
    | GotGradedResponse (Evergreen.V50.Api.Data.Data Evergreen.V50.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V50.Api.Data.Data Evergreen.V50.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V50.Scripta.API.Msg
