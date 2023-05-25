module Evergreen.V52.Pages.Study exposing (..)

import Evergreen.V52.Api.Card
import Evergreen.V52.Api.Data
import Evergreen.V52.Api.User
import Evergreen.V52.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V52.Api.Data.Data (List Evergreen.V52.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V52.Api.Data.Data Evergreen.V52.Api.Card.CardId
    , sessionSummary : Evergreen.V52.Api.Data.Data Evergreen.V52.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V52.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V52.Api.User.User
    | GotUserCards (Evergreen.V52.Api.Data.Data (List Evergreen.V52.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V52.Api.Card.CardId Evergreen.V52.Api.Card.Grade
    | GotGradedResponse (Evergreen.V52.Api.Data.Data Evergreen.V52.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V52.Api.Data.Data Evergreen.V52.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V52.Scripta.API.Msg
