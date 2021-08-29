module Evergreen.V5.Pages.Cards exposing (..)

import Evergreen.V5.Api.Card
import Evergreen.V5.Api.Data


type FormType
    = PlainTextCardType


type alias Model =
    { selectedType : FormType
    , card : Evergreen.V5.Api.Card.FlashCard
    , cardSubmitStatus : Evergreen.V5.Api.Data.Data Evergreen.V5.Api.Card.CardId
    , cardsFetchStatus : Evergreen.V5.Api.Data.Data (List Evergreen.V5.Api.Card.CardEnvelope)
    }


type PlainTextCardFormField
    = QuestionField
    | AnswerField


type Msg
    = Updated Evergreen.V5.Api.Card.PlainTextCard PlainTextCardFormField String
    | SelectedFormType FormType
    | Submitted Evergreen.V5.Api.Card.FlashCard
    | ClickedFetchCards
    | GotCard (Evergreen.V5.Api.Data.Data Evergreen.V5.Api.Card.CardId)
    | GotCards (Evergreen.V5.Api.Data.Data (List Evergreen.V5.Api.Card.CardEnvelope))
