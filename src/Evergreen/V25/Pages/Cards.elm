module Evergreen.V25.Pages.Cards exposing (..)

import Evergreen.V25.Api.Card
import Evergreen.V25.Api.Data
import Evergreen.V25.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V25.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V25.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V25.Api.Data.Data Evergreen.V25.Api.Card.CardId
    , user : Evergreen.V25.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V25.Api.Card.FlashCard Evergreen.V25.Api.User.UserId
    | GotCard (Evergreen.V25.Api.Data.Data Evergreen.V25.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg
