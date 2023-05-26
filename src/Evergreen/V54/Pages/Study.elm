module Evergreen.V54.Pages.Study exposing (..)

import Evergreen.V54.Api.Card
import Evergreen.V54.Api.Data
import Evergreen.V54.Api.User
import Evergreen.V54.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V54.Api.Data.Data (List Evergreen.V54.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V54.Api.Data.Data Evergreen.V54.Api.Card.CardId
    , sessionSummary : Evergreen.V54.Api.Data.Data Evergreen.V54.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V54.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V54.Api.User.User
    | GotUserCards (Evergreen.V54.Api.Data.Data (List Evergreen.V54.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V54.Api.Card.CardId Evergreen.V54.Api.Card.Grade
    | GotGradedResponse (Evergreen.V54.Api.Data.Data Evergreen.V54.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V54.Api.Data.Data Evergreen.V54.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V54.Scripta.API.Msg
