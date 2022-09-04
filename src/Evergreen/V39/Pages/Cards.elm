module Evergreen.V39.Pages.Cards exposing (..)

import Evergreen.V39.Api.Card
import Evergreen.V39.Api.Data
import Evergreen.V39.Api.User
import Evergreen.V39.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V39.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V39.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V39.Api.Data.Data Evergreen.V39.Api.Card.CardId
    , user : Evergreen.V39.Api.User.User
    , count : Int
    }


type EditorField
    = PlainText_Question
    | PlainText_Answer
    | Markdown_Question
    | Markdown_Answer


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V39.Api.Card.FlashCard Evergreen.V39.Api.User.UserId
    | GotCard (Evergreen.V39.Api.Data.Data Evergreen.V39.Api.Card.CardId)
    | Render Evergreen.V39.Scripta.API.Msg
