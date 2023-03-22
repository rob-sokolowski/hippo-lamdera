module Evergreen.V43.Pages.Study exposing (..)

import Evergreen.V43.Api.Card
import Evergreen.V43.Api.Data
import Evergreen.V43.Api.User
import Evergreen.V43.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V43.Api.Data.Data (List Evergreen.V43.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V43.Api.Data.Data Evergreen.V43.Api.Card.CardId
    , sessionSummary : Evergreen.V43.Api.Data.Data Evergreen.V43.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V43.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V43.Api.User.User
    | GotUserCards (Evergreen.V43.Api.Data.Data (List Evergreen.V43.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V43.Api.Card.CardId Evergreen.V43.Api.Card.Grade
    | GotGradedResponse (Evergreen.V43.Api.Data.Data Evergreen.V43.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V43.Api.Data.Data Evergreen.V43.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V43.Scripta.API.Msg
