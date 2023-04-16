module Evergreen.V49.Pages.Cards exposing (..)

import Evergreen.V49.Api.Card
import Evergreen.V49.Api.Data
import Evergreen.V49.Api.User
import Evergreen.V49.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V49.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V49.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V49.Api.Data.Data Evergreen.V49.Api.Card.CardId
    , user : Evergreen.V49.Api.User.User
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
    | Submitted Evergreen.V49.Api.Card.FlashCard Evergreen.V49.Api.User.UserId
    | GotCard (Evergreen.V49.Api.Data.Data Evergreen.V49.Api.Card.CardId)
    | Render Evergreen.V49.Scripta.API.Msg
    | Noop String
