module Evergreen.V56.Pages.Study exposing (..)

import Evergreen.V56.Api.Card
import Evergreen.V56.Api.Data
import Evergreen.V56.Api.User
import Evergreen.V56.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V56.Api.Data.Data (List Evergreen.V56.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V56.Api.Data.Data Evergreen.V56.Api.Card.CardId
    , sessionSummary : Evergreen.V56.Api.Data.Data Evergreen.V56.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V56.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V56.Api.User.User
    | GotUserCards (Evergreen.V56.Api.Data.Data (List Evergreen.V56.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V56.Api.Card.CardId Evergreen.V56.Api.Card.Grade
    | GotGradedResponse (Evergreen.V56.Api.Data.Data Evergreen.V56.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V56.Api.Data.Data Evergreen.V56.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V56.Scripta.API.Msg
