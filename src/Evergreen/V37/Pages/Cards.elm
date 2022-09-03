module Evergreen.V37.Pages.Cards exposing (..)

import Evergreen.V37.Api.Card
import Evergreen.V37.Api.Data
import Evergreen.V37.Api.User
import Evergreen.V37.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | PlainTextRadioOption


type EditorForm
    = PlainTextForm Evergreen.V37.Api.Card.PlainTextCard
    | MarkdownForm Evergreen.V37.Api.Card.MarkdownCard


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V37.Api.Data.Data Evergreen.V37.Api.Card.CardId
    , user : Evergreen.V37.Api.User.User
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
    | Submitted Evergreen.V37.Api.Card.FlashCard Evergreen.V37.Api.User.UserId
    | GotCard (Evergreen.V37.Api.Data.Data Evergreen.V37.Api.Card.CardId)
    | Render Evergreen.V37.Scripta.API.Msg
