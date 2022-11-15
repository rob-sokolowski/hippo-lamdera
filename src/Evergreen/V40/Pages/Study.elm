module Evergreen.V40.Pages.Study exposing (..)

import Evergreen.V40.Api.Card
import Evergreen.V40.Api.Data
import Evergreen.V40.Api.User
import Evergreen.V40.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V40.Api.Data.Data (List Evergreen.V40.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V40.Api.Data.Data Evergreen.V40.Api.Card.CardId
    , sessionSummary : Evergreen.V40.Api.Data.Data Evergreen.V40.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V40.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V40.Api.User.User
    | GotUserCards (Evergreen.V40.Api.Data.Data (List Evergreen.V40.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V40.Api.Card.CardId Evergreen.V40.Api.Card.Grade
    | GotGradedResponse (Evergreen.V40.Api.Data.Data Evergreen.V40.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V40.Api.Data.Data Evergreen.V40.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V40.Scripta.API.Msg
