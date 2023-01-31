module Evergreen.V41.Pages.Cards exposing (..)

import Evergreen.V41.Api.Card
import Evergreen.V41.Api.Data
import Evergreen.V41.Api.User
import Evergreen.V41.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V41.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V41.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V41.Api.Data.Data Evergreen.V41.Api.Card.CardId
    , user : Evergreen.V41.Api.User.User
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
    | Submitted Evergreen.V41.Api.Card.FlashCard Evergreen.V41.Api.User.UserId
    | GotCard (Evergreen.V41.Api.Data.Data Evergreen.V41.Api.Card.CardId)
    | Render Evergreen.V41.Scripta.API.Msg
    | Noop String
