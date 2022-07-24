module Evergreen.V19.Pages.Cards exposing (..)

import Evergreen.V19.Api.Card
import Evergreen.V19.Api.Data
import Evergreen.V19.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V19.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V19.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V19.Api.Data.Data Evergreen.V19.Api.Card.CardId
    , user : Evergreen.V19.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V19.Api.Card.FlashCard Evergreen.V19.Api.User.UserId
    | GotCard (Evergreen.V19.Api.Data.Data Evergreen.V19.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg
