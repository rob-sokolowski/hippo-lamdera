module Evergreen.V10.Pages.Cards exposing (..)

import Evergreen.V10.Api.Card
import Evergreen.V10.Api.Data
import Evergreen.V10.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V10.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V10.Api.Card.MarkdownCard


type alias Model = 
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.Card.CardId)
    , user : Evergreen.V10.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V10.Api.Card.FlashCard Evergreen.V10.Api.User.UserId
    | GotCard (Evergreen.V10.Api.Data.Data Evergreen.V10.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg