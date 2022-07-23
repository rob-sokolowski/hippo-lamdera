module Evergreen.V16.Pages.Cards exposing (..)

import Evergreen.V16.Api.Card
import Evergreen.V16.Api.Data
import Evergreen.V16.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V16.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V16.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V16.Api.Data.Data Evergreen.V16.Api.Card.CardId
    , user : Evergreen.V16.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V16.Api.Card.FlashCard Evergreen.V16.Api.User.UserId
    | GotCard (Evergreen.V16.Api.Data.Data Evergreen.V16.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg
