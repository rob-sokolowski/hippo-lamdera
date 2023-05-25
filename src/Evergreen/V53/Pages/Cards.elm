module Evergreen.V53.Pages.Cards exposing (..)

import Evergreen.V53.Api.Card
import Evergreen.V53.Api.Data
import Evergreen.V53.Api.User
import Evergreen.V53.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | AiAssistRadioOption


type EditorForm
    = MarkdownForm Evergreen.V53.Api.Card.MarkdownCard
    | AiAssistedMarkdownForm (List Evergreen.V53.Api.Card.MarkdownCard)


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V53.Api.Data.Data Evergreen.V53.Api.Card.CardId
    , user : Evergreen.V53.Api.User.User
    , count : Int
    }


type EditorField
    = Markdown_Question
    | Markdown_Answer
    | Markdown_Tag


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V53.Api.Card.FlashCard Evergreen.V53.Api.User.UserId
    | GotCard (Evergreen.V53.Api.Data.Data Evergreen.V53.Api.Card.CardId)
    | Render Evergreen.V53.Scripta.API.Msg
    | Noop String
