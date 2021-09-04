module Evergreen.V7.Pages.Cards exposing (..)

import Evergreen.V7.Api.Card
import Evergreen.V7.Api.Data
import Evergreen.V7.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V7.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V7.Api.Card.MarkdownCard


type alias Model = 
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.Card.CardId)
    , user : Evergreen.V7.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V7.Api.Card.FlashCard Evergreen.V7.Api.User.UserId
    | GotCard (Evergreen.V7.Api.Data.Data Evergreen.V7.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg