module Evergreen.V41.Pages.Study exposing (..)

import Evergreen.V41.Api.Card
import Evergreen.V41.Api.Data
import Evergreen.V41.Api.User
import Evergreen.V41.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V41.Api.Data.Data (List Evergreen.V41.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V41.Api.Data.Data Evergreen.V41.Api.Card.CardId
    , sessionSummary : Evergreen.V41.Api.Data.Data Evergreen.V41.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V41.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V41.Api.User.User
    | GotUserCards (Evergreen.V41.Api.Data.Data (List Evergreen.V41.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V41.Api.Card.CardId Evergreen.V41.Api.Card.Grade
    | GotGradedResponse (Evergreen.V41.Api.Data.Data Evergreen.V41.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V41.Api.Data.Data Evergreen.V41.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V41.Scripta.API.Msg
