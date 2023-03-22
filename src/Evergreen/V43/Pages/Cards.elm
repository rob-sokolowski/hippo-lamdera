module Evergreen.V43.Pages.Cards exposing (..)

import Evergreen.V43.Api.Card
import Evergreen.V43.Api.Data
import Evergreen.V43.Api.User
import Evergreen.V43.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V43.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V43.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V43.Api.Data.Data Evergreen.V43.Api.Card.CardId
    , user : Evergreen.V43.Api.User.User
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
    | Submitted Evergreen.V43.Api.Card.FlashCard Evergreen.V43.Api.User.UserId
    | GotCard (Evergreen.V43.Api.Data.Data Evergreen.V43.Api.Card.CardId)
    | Render Evergreen.V43.Scripta.API.Msg
    | Noop String
