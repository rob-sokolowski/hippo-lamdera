module Evergreen.V51.Pages.Study exposing (..)

import Evergreen.V51.Api.Card
import Evergreen.V51.Api.Data
import Evergreen.V51.Api.User
import Evergreen.V51.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V51.Api.Data.Data (List Evergreen.V51.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V51.Api.Data.Data Evergreen.V51.Api.Card.CardId
    , sessionSummary : Evergreen.V51.Api.Data.Data Evergreen.V51.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V51.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V51.Api.User.User
    | GotUserCards (Evergreen.V51.Api.Data.Data (List Evergreen.V51.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V51.Api.Card.CardId Evergreen.V51.Api.Card.Grade
    | GotGradedResponse (Evergreen.V51.Api.Data.Data Evergreen.V51.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V51.Api.Data.Data Evergreen.V51.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V51.Scripta.API.Msg
