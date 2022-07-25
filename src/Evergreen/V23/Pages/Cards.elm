module Evergreen.V23.Pages.Cards exposing (..)

import Evergreen.V23.Api.Card
import Evergreen.V23.Api.Data
import Evergreen.V23.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V23.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V23.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V23.Api.Data.Data Evergreen.V23.Api.Card.CardId
    , user : Evergreen.V23.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V23.Api.Card.FlashCard Evergreen.V23.Api.User.UserId
    | GotCard (Evergreen.V23.Api.Data.Data Evergreen.V23.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg
