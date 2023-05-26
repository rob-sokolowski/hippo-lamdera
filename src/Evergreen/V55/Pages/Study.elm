module Evergreen.V55.Pages.Study exposing (..)

import Evergreen.V55.Api.Card
import Evergreen.V55.Api.Data
import Evergreen.V55.Api.User
import Evergreen.V55.Scripta.API


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V55.Api.Data.Data (List Evergreen.V55.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V55.Api.Data.Data Evergreen.V55.Api.Card.CardId
    , sessionSummary : Evergreen.V55.Api.Data.Data Evergreen.V55.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V55.Api.User.User
    }


type Msg
    = FetchCards Evergreen.V55.Api.User.User
    | GotUserCards (Evergreen.V55.Api.Data.Data (List Evergreen.V55.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V55.Api.Card.CardId Evergreen.V55.Api.Card.Grade
    | GotGradedResponse (Evergreen.V55.Api.Data.Data Evergreen.V55.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V55.Api.Data.Data Evergreen.V55.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V55.Scripta.API.Msg
