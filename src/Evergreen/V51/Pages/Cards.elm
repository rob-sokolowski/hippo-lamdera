module Evergreen.V51.Pages.Cards exposing (..)

import Evergreen.V51.Api.Card
import Evergreen.V51.Api.Data
import Evergreen.V51.Api.User
import Evergreen.V51.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | AiAssistRadioOption


type EditorForm
    = MarkdownForm Evergreen.V51.Api.Card.MarkdownCard
    | AiAssistedMarkdownForm (List Evergreen.V51.Api.Card.MarkdownCard)


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V51.Api.Data.Data Evergreen.V51.Api.Card.CardId
    , user : Evergreen.V51.Api.User.User
    , count : Int
    }


type EditorField
    = Markdown_Question
    | Markdown_Answer
    | Markdown_Tag


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V51.Api.Card.FlashCard Evergreen.V51.Api.User.UserId
    | GotCard (Evergreen.V51.Api.Data.Data Evergreen.V51.Api.Card.CardId)
    | Render Evergreen.V51.Scripta.API.Msg
    | Noop String
