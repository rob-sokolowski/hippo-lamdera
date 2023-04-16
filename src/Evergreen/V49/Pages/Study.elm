module Evergreen.V49.Pages.Study exposing (..)

import Evergreen.V49.Api.Card
import Evergreen.V49.Api.Data
import Evergreen.V49.Api.User
import Evergreen.V49.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V49.Api.Data.Data (List Evergreen.V49.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V49.Api.Data.Data Evergreen.V49.Api.Card.CardId
    , sessionSummary : Evergreen.V49.Api.Data.Data Evergreen.V49.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V49.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V49.Api.User.User
    | GotUserCards (Evergreen.V49.Api.Data.Data (List Evergreen.V49.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V49.Api.Card.CardId Evergreen.V49.Api.Card.Grade
    | GotGradedResponse (Evergreen.V49.Api.Data.Data Evergreen.V49.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V49.Api.Data.Data Evergreen.V49.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V49.Scripta.API.Msg
