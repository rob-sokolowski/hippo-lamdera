module Evergreen.V53.Pages.Study exposing (..)

import Evergreen.V53.Api.Card
import Evergreen.V53.Api.Data
import Evergreen.V53.Api.User
import Evergreen.V53.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V53.Api.Data.Data (List Evergreen.V53.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V53.Api.Data.Data Evergreen.V53.Api.Card.CardId
    , sessionSummary : Evergreen.V53.Api.Data.Data Evergreen.V53.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V53.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V53.Api.User.User
    | GotUserCards (Evergreen.V53.Api.Data.Data (List Evergreen.V53.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V53.Api.Card.CardId Evergreen.V53.Api.Card.Grade
    | GotGradedResponse (Evergreen.V53.Api.Data.Data Evergreen.V53.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V53.Api.Data.Data Evergreen.V53.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V53.Scripta.API.Msg
