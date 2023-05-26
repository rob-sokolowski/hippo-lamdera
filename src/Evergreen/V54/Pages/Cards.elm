module Evergreen.V54.Pages.Cards exposing (..)

import Evergreen.V54.Api.Card
import Evergreen.V54.Api.Data
import Evergreen.V54.Api.User
import Evergreen.V54.Scripta.API


type SelectedFormRadioOption
    = MarkdownRadioOption
    | AiAssistRadioOption


type EditorForm
    = MarkdownForm Evergreen.V54.Api.Card.MarkdownCard
    | AiAssistedMarkdownForm (List Evergreen.V54.Api.Card.MarkdownCard)


type alias Model =
    { selectedOption : SelectedFormRadioOption
    , editorForm : EditorForm
    , cardSubmitStatus : Evergreen.V54.Api.Data.Data Evergreen.V54.Api.Card.CardId
    , user : Evergreen.V54.Api.User.User
    , count : Int
    }


type EditorField
    = Markdown_Question
    | Markdown_Answer
    | Markdown_Tag


type Msg
    = FormUpdated EditorForm EditorField String
    | ToggledOption SelectedFormRadioOption
    | Submitted Evergreen.V54.Api.Card.FlashCard Evergreen.V54.Api.User.UserId
    | GotCard (Evergreen.V54.Api.Data.Data Evergreen.V54.Api.Card.CardId)
    | Render Evergreen.V54.Scripta.API.Msg
    | Noop String
