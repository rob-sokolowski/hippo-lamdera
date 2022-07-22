module Evergreen.V13.Pages.Cards exposing (..)

import Evergreen.V13.Api.Card
import Evergreen.V13.Api.Data
import Evergreen.V13.Api.User
import Markdown.Render


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V13.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V13.Api.Card.MarkdownCard


type alias Model = 
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.Card.CardId)
    , user : Evergreen.V13.Api.User.User
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = Updated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V13.Api.Card.FlashCard Evergreen.V13.Api.User.UserId
    | GotCard (Evergreen.V13.Api.Data.Data Evergreen.V13.Api.Card.CardId)
    | MarkdownMsg Markdown.Render.MarkdownMsg