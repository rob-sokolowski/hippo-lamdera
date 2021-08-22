module Evergreen.V4.Pages.Cards exposing (..)

import Evergreen.V4.Api.Card
import Evergreen.V4.Api.Data


type FormType
    = PlainTextCardType


type alias Model =
    { selectedType : FormType
    , card : Evergreen.V4.Api.Card.FlashCard
    , cardSubmitStatus : Evergreen.V4.Api.Data.Data Evergreen.V4.Api.Card.CardId
    }


type PlainTextCardFormField
    = QuestionField
    | AnswerField


type Msg
    = Updated Evergreen.V4.Api.Card.PlainTextCard PlainTextCardFormField String
    | SelectedFormType FormType
    | Submitted Evergreen.V4.Api.Card.FlashCard
    | GotCard (Evergreen.V4.Api.Data.Data Evergreen.V4.Api.Card.CardId)
