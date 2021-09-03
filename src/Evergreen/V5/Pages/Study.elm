module Evergreen.V5.Pages.Study exposing (..)

import Evergreen.V5.Api.Card
import Evergreen.V5.Api.Data
import Evergreen.V5.Api.User


type PromptStatus
    = Idle
    | QuestionPrompted
    | AnswerRevealed


type alias Model = 
    { cardDataFetch : (Evergreen.V5.Api.Data.Data (List Evergreen.V5.Api.Card.CardEnvelope))
    , promptStatus : PromptStatus
    , gradeSubmit : (Evergreen.V5.Api.Data.Data Evergreen.V5.Api.Card.CardId)
    }


type Msg
    = FetchCards Evergreen.V5.Api.User.User
    | GotUserCards (Evergreen.V5.Api.Data.Data (List Evergreen.V5.Api.Card.CardEnvelope))
    | UserClickedReveal
    | UserSelfGrade Evergreen.V5.Api.Card.CardId Evergreen.V5.Api.Card.Grade
    | GotGradedResponse (Evergreen.V5.Api.Data.Data Evergreen.V5.Api.Card.CardId)