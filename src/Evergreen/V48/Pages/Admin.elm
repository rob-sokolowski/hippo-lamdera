module Evergreen.V48.Pages.Admin exposing (..)

import Evergreen.V48.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V48.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V48.Api.Admin.AdminSummary)
