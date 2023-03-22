module Evergreen.V45.Pages.Cards exposing (..)

import Evergreen.V45.Api.Card
import Evergreen.V45.Api.Data
import Evergreen.V45.Api.User
import Evergreen.V45.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V45.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V45.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V45.Api.Data.Data Evergreen.V45.Api.Card.CardId
    , user : Evergreen.V45.Api.User.User
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
    | Submitted Evergreen.V45.Api.Card.FlashCard Evergreen.V45.Api.User.UserId
    | GotCard (Evergreen.V45.Api.Data.Data Evergreen.V45.Api.Card.CardId)
    | Render Evergreen.V45.Scripta.API.Msg
    | Noop String
