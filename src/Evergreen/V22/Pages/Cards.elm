module Evergreen.V22.Pages.Cards exposing (..)

import Evergreen.V22.Api.Card
import Evergreen.V22.Api.Data
import Evergreen.V22.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V22.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V22.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V22.Api.Data.Data Evergreen.V22.Api.Card.CardId
    , user : Evergreen.V22.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V22.Api.Card.FlashCard Evergreen.V22.Api.User.UserId
    | GotCard (Evergreen.V22.Api.Data.Data Evergreen.V22.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg
