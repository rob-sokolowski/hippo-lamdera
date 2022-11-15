module Evergreen.V40.Pages.Cards exposing (..)

import Evergreen.V40.Api.Card
import Evergreen.V40.Api.Data
import Evergreen.V40.Api.User
import Evergreen.V40.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V40.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V40.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V40.Api.Data.Data Evergreen.V40.Api.Card.CardId
    , user : Evergreen.V40.Api.User.User
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
    | Submitted Evergreen.V40.Api.Card.FlashCard Evergreen.V40.Api.User.UserId
    | GotCard (Evergreen.V40.Api.Data.Data Evergreen.V40.Api.Card.CardId)
    | Render Evergreen.V40.Scripta.API.Msg
    | Noop String
