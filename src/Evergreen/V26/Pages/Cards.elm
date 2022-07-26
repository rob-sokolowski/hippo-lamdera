module Evergreen.V26.Pages.Cards exposing (..)

import Evergreen.V26.Api.Card
import Evergreen.V26.Api.Data
import Evergreen.V26.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V26.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V26.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V26.Api.Data.Data Evergreen.V26.Api.Card.CardId
    , user : Evergreen.V26.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V26.Api.Card.FlashCard Evergreen.V26.Api.User.UserId
    | GotCard (Evergreen.V26.Api.Data.Data Evergreen.V26.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg
