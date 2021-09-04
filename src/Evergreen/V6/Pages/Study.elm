module Evergreen.V6.Pages.Study exposing (..)

import Evergreen.V6.Api.Card
import Evergreen.V6.Api.Data
import Evergreen.V6.Api.User


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model = 
    { cardDataFetch : (Evergreen.V6.Api.Data.Data (List Evergreen.V6.Api.Card.CardEnvelope))
    , promptStatus : PromptStatus
    , gradeSubmit : (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.Card.CardId)
    , sessionSummary : (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.Card.StudySessionSummary)
    , user : (Maybe Evergreen.V6.Api.User.User)
    }


type Msg
    = FetchCards Evergreen.V6.Api.User.User
    | GotUserCards (Evergreen.V6.Api.Data.Data (List Evergreen.V6.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V6.Api.Card.CardId Evergreen.V6.Api.Card.Grade
    | GotGradedResponse (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.Card.CardId)
    | GotStudySessionSummary (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.Card.StudySessionSummary)
    | UserStartStudySession