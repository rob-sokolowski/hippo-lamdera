module Evergreen.V56.Pages.Cards exposing (..)

import Evergreen.V56.Api.Card
import Evergreen.V56.Api.Data
import Evergreen.V56.Api.User
import Evergreen.V56.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | AiAssistRadioOption


type EditorForm
    = MarkdownForm Evergreen.V56.Api.Card.MarkdownCard
    | AiAssistedMarkdownForm (List Evergreen.V56.Api.Card.MarkdownCard)


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V56.Api.Data.Data Evergreen.V56.Api.Card.CardId
    , user : Evergreen.V56.Api.User.User
    , count : Int
    }


type EditorField
    = Markdown_Question
    | Markdown_Answer
    | Markdown_Tag


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V56.Api.Card.FlashCard Evergreen.V56.Api.User.UserId
    | GotCard (Evergreen.V56.Api.Data.Data Evergreen.V56.Api.Card.CardId)
    | Render Evergreen.V56.Scripta.API.Msg
    | Noop String
