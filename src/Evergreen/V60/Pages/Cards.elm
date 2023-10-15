module Evergreen.V60.Pages.Cards exposing (..)

import Evergreen.V60.Api.Card
import Evergreen.V60.Api.Data
import Evergreen.V60.Api.User
import Evergreen.V60.Scripta.API


type EditorForm
    = MarkdownForm Evergreen.V60.Api.Card.MarkdownCard
    | AiAssistedMarkdownForm (List Evergreen.V60.Api.Card.MarkdownCard)


type EditorField
    = Markdown_Question
    | Markdown_Answer
    | Markdown_Tag


type SelectedFormRadioOption
    = MarkdownRadioOption
    | AiAssistRadioOption


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V60.Api.Card.FlashCard Evergreen.V60.Api.User.UserId
    | GotCard (Evergreen.V60.Api.Data.Data Evergreen.V60.Api.Card.CardId)
    | Render Evergreen.V60.Scripta.API.Msg
    | Noop String


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V60.Api.Data.Data Evergreen.V60.Api.Card.CardId
    , user : Evergreen.V60.Api.User.User
    , count : Int
    }
