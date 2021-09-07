module Evergreen.V9.Pages.Cards exposing (..)

import Evergreen.V9.Api.Card
import Evergreen.V9.Api.Data
import Evergreen.V9.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V9.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V9.Api.Card.MarkdownCard


type alias Model = 
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.Card.CardId)
    , user : Evergreen.V9.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V9.Api.Card.FlashCard Evergreen.V9.Api.User.UserId
    | GotCard (Evergreen.V9.Api.Data.Data Evergreen.V9.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg