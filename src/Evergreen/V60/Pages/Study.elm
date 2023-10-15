module Evergreen.V60.Pages.Study exposing (..)

import Evergreen.V60.Api.Card
import Evergreen.V60.Api.Data
import Evergreen.V60.Api.User
import Evergreen.V60.Scripta.API


type Msg
    = FetchCards Evergreen.V60.Api.User.User
    | GotUserCards (Evergreen.V60.Api.Data.Data (List Evergreen.V60.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V60.Api.Card.CardId Evergreen.V60.Api.Card.Grade
    | GotGradedResponse (Evergreen.V60.Api.Data.Data Evergreen.V60.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V60.Api.Data.Data Evergreen.V60.Api.Card.StudySessionSummary)
    | UserStartStudySession
    | Render Evergreen.V60.Scripta.API.Msg


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model =
    { cardDataFetch : Evergreen.V60.Api.Data.Data (List Evergreen.V60.Api.Card.CardEnvelope)
    , promptStatus : PromptStatus
    , gradeSubmit : Evergreen.V60.Api.Data.Data Evergreen.V60.Api.Card.CardId
    , sessionSummary : Evergreen.V60.Api.Data.Data Evergreen.V60.Api.Card.StudySessionSummary
    , user : Maybe Evergreen.V60.Api.User.User
    }
