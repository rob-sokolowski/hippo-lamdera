module Evergreen.V50.Pages.Cards exposing (..)

import Evergreen.V50.Api.Card
import Evergreen.V50.Api.Data
import Evergreen.V50.Api.User
import Evergreen.V50.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | AiAssistRadioOption


type EditorForm
    = MarkdownForm Evergreen.V50.Api.Card.MarkdownCard
    | AiAssistedMarkdownForm (List Evergreen.V50.Api.Card.MarkdownCard)


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V50.Api.Data.Data Evergreen.V50.Api.Card.CardId
    , user : Evergreen.V50.Api.User.User
    , count : Int
    }


type EditorField
    = Markdown_Question
    | Markdown_Answer
    | Markdown_Tag


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V50.Api.Card.FlashCard Evergreen.V50.Api.User.UserId
    | GotCard (Evergreen.V50.Api.Data.Data Evergreen.V50.Api.Card.CardId)
    | Render Evergreen.V50.Scripta.API.Msg
    | Noop String
