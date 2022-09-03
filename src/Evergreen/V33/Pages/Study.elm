module Evergreen.V33.Pages.Study exposing (..)

import Evergreen.V33.Api.Card
import Evergreen.V33.Api.Data
import Evergreen.V33.Api.User
import Evergreen.V33.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V33.Api.Data.Data (List Evergreen.V33.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V33.Api.Data.Data Evergreen.V33.Api.Card.CardId
    , sessionSummary : Evergreen.V33.Api.Data.Data Evergreen.V33.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V33.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V33.Api.User.User
    | GotUserCards (Evergreen.V33.Api.Data.Data (List Evergreen.V33.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V33.Api.Card.CardId Evergreen.V33.Api.Card.Grade
    | GotGradedResponse (Evergreen.V33.Api.Data.Data Evergreen.V33.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V33.Api.Data.Data Evergreen.V33.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V33.Scripta.API.Msg
