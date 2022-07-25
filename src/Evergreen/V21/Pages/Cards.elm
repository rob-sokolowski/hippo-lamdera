module Evergreen.V21.Pages.Cards exposing (..)

import Evergreen.V21.Api.Card
import Evergreen.V21.Api.Data
import Evergreen.V21.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V21.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V21.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V21.Api.Data.Data Evergreen.V21.Api.Card.CardId
    , user : Evergreen.V21.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V21.Api.Card.FlashCard Evergreen.V21.Api.User.UserId
    | GotCard (Evergreen.V21.Api.Data.Data Evergreen.V21.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg
