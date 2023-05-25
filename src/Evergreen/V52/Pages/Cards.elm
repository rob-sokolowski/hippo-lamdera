module Evergreen.V52.Pages.Cards exposing (..)

import Evergreen.V52.Api.Card
import Evergreen.V52.Api.Data
import Evergreen.V52.Api.User
import Evergreen.V52.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | AiAssistRadioOption


type EditorForm
    = MarkdownForm Evergreen.V52.Api.Card.MarkdownCard
    | AiAssistedMarkdownForm (List Evergreen.V52.Api.Card.MarkdownCard)


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V52.Api.Data.Data Evergreen.V52.Api.Card.CardId
    , user : Evergreen.V52.Api.User.User
    , count : Int
    }


type EditorField
    = Markdown_Question
    | Markdown_Answer
    | Markdown_Tag


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V52.Api.Card.FlashCard Evergreen.V52.Api.User.UserId
    | GotCard (Evergreen.V52.Api.Data.Data Evergreen.V52.Api.Card.CardId)
    | Render Evergreen.V52.Scripta.API.Msg
    | Noop String
