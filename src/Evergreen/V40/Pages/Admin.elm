module Evergreen.V40.Pages.Admin exposing (..)

import Evergreen.V40.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V40.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V40.Api.Admin.AdminSummary)
