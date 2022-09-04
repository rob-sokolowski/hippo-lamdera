module Evergreen.V39.Pages.Admin exposing (..)

import Evergreen.V39.Api.Admin


type alias Model =
    { adminSummary : Maybe (List Evergreen.V39.Api.Admin.AdminSummary)
    }


type Msg
    = GotAdminSummary (List Evergreen.V39.Api.Admin.AdminSummary)
