module Evergreen.V48.Pages.Cards exposing (..)

import Evergreen.V48.Api.Card
import Evergreen.V48.Api.Data
import Evergreen.V48.Api.User
import Evergreen.V48.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V48.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V48.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V48.Api.Data.Data Evergreen.V48.Api.Card.CardId
    , user : Evergreen.V48.Api.User.User
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
    | Submitted Evergreen.V48.Api.Card.FlashCard Evergreen.V48.Api.User.UserId
    | GotCard (Evergreen.V48.Api.Data.Data Evergreen.V48.Api.Card.CardId)
    | Render Evergreen.V48.Scripta.API.Msg
    | Noop String
