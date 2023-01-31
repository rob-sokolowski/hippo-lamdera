module Evergreen.V42.Pages.Study exposing (..)

import Evergreen.V42.Api.Card
import Evergreen.V42.Api.Data
import Evergreen.V42.Api.User
import Evergreen.V42.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V42.Api.Data.Data (List Evergreen.V42.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V42.Api.Data.Data Evergreen.V42.Api.Card.CardId
    , sessionSummary : Evergreen.V42.Api.Data.Data Evergreen.V42.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V42.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V42.Api.User.User
    | GotUserCards (Evergreen.V42.Api.Data.Data (List Evergreen.V42.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V42.Api.Card.CardId Evergreen.V42.Api.Card.Grade
    | GotGradedResponse (Evergreen.V42.Api.Data.Data Evergreen.V42.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V42.Api.Data.Data Evergreen.V42.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V42.Scripta.API.Msg
