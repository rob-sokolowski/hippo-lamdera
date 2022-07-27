module Evergreen.V28.Pages.Cards exposing (..)

import Evergreen.V28.Api.Card
import Evergreen.V28.Api.Data
import Evergreen.V28.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V28.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V28.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V28.Api.Data.Data Evergreen.V28.Api.Card.CardId
    , user : Evergreen.V28.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V28.Api.Card.FlashCard Evergreen.V28.Api.User.UserId
    | GotCard (Evergreen.V28.Api.Data.Data Evergreen.V28.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg
