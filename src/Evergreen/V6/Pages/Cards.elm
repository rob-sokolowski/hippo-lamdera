module Evergreen.V6.Pages.Cards exposing (..)

import Evergreen.V6.Api.Card
import Evergreen.V6.Api.Data
import Evergreen.V6.Api.User


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V6.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V6.Api.Card.MarkdownCard


type alias Model = 
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.Card.CardId)
    , user : Evergreen.V6.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V6.Api.Card.FlashCard Evergreen.V6.Api.User.UserId
    | GotCard (Evergreen.V6.Api.Data.Data Evergreen.V6.Api.Card.CardId)