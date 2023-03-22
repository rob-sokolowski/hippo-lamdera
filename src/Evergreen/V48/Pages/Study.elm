module Evergreen.V48.Pages.Study exposing (..)

import Evergreen.V48.Api.Card
import Evergreen.V48.Api.Data
import Evergreen.V48.Api.User
import Evergreen.V48.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V48.Api.Data.Data (List Evergreen.V48.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V48.Api.Data.Data Evergreen.V48.Api.Card.CardId
    , sessionSummary : Evergreen.V48.Api.Data.Data Evergreen.V48.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V48.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V48.Api.User.User
    | GotUserCards (Evergreen.V48.Api.Data.Data (List Evergreen.V48.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V48.Api.Card.CardId Evergreen.V48.Api.Card.Grade
    | GotGradedResponse (Evergreen.V48.Api.Data.Data Evergreen.V48.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V48.Api.Data.Data Evergreen.V48.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V48.Scripta.API.Msg
