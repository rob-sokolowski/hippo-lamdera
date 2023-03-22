module Evergreen.V45.Pages.Study exposing (..)

import Evergreen.V45.Api.Card
import Evergreen.V45.Api.Data
import Evergreen.V45.Api.User
import Evergreen.V45.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V45.Api.Data.Data (List Evergreen.V45.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V45.Api.Data.Data Evergreen.V45.Api.Card.CardId
    , sessionSummary : Evergreen.V45.Api.Data.Data Evergreen.V45.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V45.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V45.Api.User.User
    | GotUserCards (Evergreen.V45.Api.Data.Data (List Evergreen.V45.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V45.Api.Card.CardId Evergreen.V45.Api.Card.Grade
    | GotGradedResponse (Evergreen.V45.Api.Data.Data Evergreen.V45.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V45.Api.Data.Data Evergreen.V45.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V45.Scripta.API.Msg
