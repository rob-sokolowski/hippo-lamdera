module Evergreen.V55.Pages.Cards exposing (..)

import Evergreen.V55.Api.Card
import Evergreen.V55.Api.Data
import Evergreen.V55.Api.User
import Evergreen.V55.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | AiAssistRadioOption


type EditorForm
    = MarkdownForm Evergreen.V55.Api.Card.MarkdownCard
    | AiAssistedMarkdownForm (List Evergreen.V55.Api.Card.MarkdownCard)


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V55.Api.Data.Data Evergreen.V55.Api.Card.CardId
    , user : Evergreen.V55.Api.User.User
    , count : Int
    }


type EditorField
    = Markdown_Question
    | Markdown_Answer
    | Markdown_Tag


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V55.Api.Card.FlashCard Evergreen.V55.Api.User.UserId
    | GotCard (Evergreen.V55.Api.Data.Data Evergreen.V55.Api.Card.CardId)
    | Render Evergreen.V55.Scripta.API.Msg
    | Noop String
