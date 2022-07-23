module Evergreen.V17.Pages.Cards exposing (..)

import Evergreen.V17.Api.Card
import Evergreen.V17.Api.Data
import Evergreen.V17.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V17.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V17.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V17.Api.Data.Data Evergreen.V17.Api.Card.CardId
    , user : Evergreen.V17.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V17.Api.Card.FlashCard Evergreen.V17.Api.User.UserId
    | GotCard (Evergreen.V17.Api.Data.Data Evergreen.V17.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg
