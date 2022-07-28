module Evergreen.V30.Pages.Cards exposing (..)

import Evergreen.V30.Api.Card
import Evergreen.V30.Api.Data
import Evergreen.V30.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V30.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V30.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V30.Api.Data.Data Evergreen.V30.Api.Card.CardId
    , user : Evergreen.V30.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V30.Api.Card.FlashCard Evergreen.V30.Api.User.UserId
    | GotCard (Evergreen.V30.Api.Data.Data Evergreen.V30.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg
