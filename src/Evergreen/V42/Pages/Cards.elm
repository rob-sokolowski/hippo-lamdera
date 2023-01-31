module Evergreen.V42.Pages.Cards exposing (..)

import Evergreen.V42.Api.Card
import Evergreen.V42.Api.Data
import Evergreen.V42.Api.User
import Evergreen.V42.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V42.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V42.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V42.Api.Data.Data Evergreen.V42.Api.Card.CardId
    , user : Evergreen.V42.Api.User.User
    , count : Int
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer
    | Markdown_Tag


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V42.Api.Card.FlashCard Evergreen.V42.Api.User.UserId
    | GotCard (Evergreen.V42.Api.Data.Data Evergreen.V42.Api.Card.CardId)
    | Render Evergreen.V42.Scripta.API.Msg
    | Noop String
