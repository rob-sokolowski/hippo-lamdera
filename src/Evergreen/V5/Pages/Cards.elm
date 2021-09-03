module Evergreen.V5.Pages.Cards exposing (..)

import Evergreen.V5.Api.Card
import Evergreen.V5.Api.Data
import Evergreen.V5.Api.User


type FormType
    = PlainTextCardType


type alias Model = 
    { selectedType : FormType
    , card : Evergreen.V5.Api.Card.FlashCard
    , cardSubmitStatus : (Evergreen.V5.Api.Data.Data Evergreen.V5.Api.Card.CardId)
    , user : Evergreen.V5.Api.User.User
    }


type PlainTextCardFormField
    = QuestionField
    | AnswerField


type Msg
    = Updated Evergreen.V5.Api.Card.PlainTextCard PlainTextCardFormField String
    | SelectedFormType FormType
    | Submitted Evergreen.V5.Api.Card.FlashCard Evergreen.V5.Api.User.UserId
    | GotCard (Evergreen.V5.Api.Data.Data Evergreen.V5.Api.Card.CardId)